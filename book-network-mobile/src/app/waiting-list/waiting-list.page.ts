import { Component, OnInit } from '@angular/core';
import { BookResponse } from '../models/bookModels/BookResponse';
import { BookService } from '../services/book/book.service';
import { AlertController, MenuController, ToastController } from '@ionic/angular';
import { NavigationEnd, Router } from '@angular/router';
import { filter } from 'rxjs';
import { BookPageResponse } from '../models/bookModels/allBookPageResponse';
import { IonInfiniteScrollCustomEvent } from '@ionic/core';

@Component({
  selector: 'app-waiting-list',
  templateUrl: './waiting-list.page.html',
  styleUrls: ['./waiting-list.page.scss'],
})
export class WaitingListPage implements OnInit {

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
  }

  ngOnInit() {
    this.loadBooks();
  }



  loadBooks(event?: IonInfiniteScrollCustomEvent<void>) {
    if (this.isLoading) return;

    this.isLoading = true;
    this.bookService.waitingList({ page: this.page, size: this.size }).subscribe({
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

  removeItem(book: BookResponse) {
    this.bookService.deleteBook(book.id as number).subscribe({
      next: async res => {
        this.books = this.books.filter(b => b.id !== book.id);
        const toast = await this.toast.create({
          message: 'Book has been borrowed successfully',
          duration: 3000,
          color: 'success',
          position: 'bottom',
        });
        await toast.present();
      }
    })
    }



}
