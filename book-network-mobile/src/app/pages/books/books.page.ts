import { Component, OnInit } from '@angular/core';
import { NavigationEnd, Router } from '@angular/router';
import { AlertController, MenuController, ToastController } from '@ionic/angular';
import { IonInfiniteScrollCustomEvent } from '@ionic/core';
import { filter } from 'rxjs';
import { BookPageResponse } from 'src/app/models/bookModels/allBookPageResponse';
import { BookResponse } from 'src/app/models/bookModels/BookResponse';
import { BookService } from 'src/app/services/book/book.service';

@Component({
  selector: 'app-books',
  templateUrl: './books.page.html',
  styleUrls: ['./books.page.scss'],
})
export class BooksPage implements OnInit {

  books: Array<BookResponse> = [];
  page: number = 0;
  size: number = 2;
  isLoading: boolean = false;
  isEmpty: boolean = false;

  constructor(
    private bookService: BookService,
    private alert: AlertController,
    private menu: MenuController,
    private toast: ToastController,
    private router: Router
  ) {
    this.router.events
      .pipe(
        filter((event) => event instanceof NavigationEnd && (event as NavigationEnd).urlAfterRedirects === '/books')
      )
      .subscribe(() => {
        console.log('Navigated to /books, refreshing book list.');
        this.refreshBooks();
      });
  }

  ngOnInit() {
    this.refreshBooks();
  }

  refreshBooks() {
    this.books = [];
    this.page = 0;
    this.loadBooks();
  }

  loadBooks(event?: IonInfiniteScrollCustomEvent<void>) {
    if (this.isLoading) return;

    this.isLoading = true;
    this.bookService.findAllBooks({ page: this.page, size: this.size }).subscribe({
      next: (response: BookPageResponse) => {
        this.books = [...this.books, ...(response.content || [])];
        this.isEmpty = this.books.length === 0;
        this.isLoading = false;

        if (event) {
          event.target.complete(); 
        }

      
        if (this.page < (response.totalPages as number) - 1) {
          this.page++;
        } else if (event) {
          event.target.disabled = true;
        }
      },
      error: async () => {
        const alert = await this.alert.create({
          header: 'Error',
          message: 'Something went wrong',
          buttons: ['OK'],
        });
        await alert.present();
        this.isLoading = false; 
      },
    });
  }

  loadMore(event: IonInfiniteScrollCustomEvent<void>) {
    this.loadBooks(event);
  }

  public selectedPicture(book: BookResponse): string | undefined {
    return book.cover ? 'data:image/jpg;base64, ' + book.cover : '';
  }

  borrowBook(book: BookResponse) {
    this.bookService.borrowBook(book.id as number).subscribe({
      next: async () => {
        const toast = await this.toast.create({
          message: 'Book has been borrowed successfully',
          duration: 3000,
          color: 'success',
          position: 'bottom',
        });
        await toast.present();
      },
      error: async (err) => {
        const toast = await this.toast.create({
          message: err.error.error,
          duration: 3000,
          color: 'danger',
          position: 'bottom',
        });
        await toast.present();
      },
    });
  }

  menuOpen() {
    this.menu.open('first');
  }

  addBookToWaitingList(book:BookResponse) {
    this.bookService.addBookToWaitingList(book.id as number).subscribe({

      next: async res => {
        const toast = await this.toast.create({
          message: 'Book in the waiting list',
          duration: 3000,
          color: 'success',
          position: 'bottom',
        });
        await toast.present();
      },
      error: async err =>{
        const toast = await this.toast.create({
          message: "book already in the waiting list",
          duration: 3000,
          color: 'danger',
          position: 'bottom',
        });
        await toast.present();

      }

    })
    }
}
