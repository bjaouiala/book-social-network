import { NgModule } from '@angular/core';
import { PreloadAllModules, RouterModule, Routes } from '@angular/router';
import { authGuard } from './services/auth.guard';

const routes: Routes = [
  {
    path: 'home',
    loadChildren: () => import('./pages/home/home.module').then( m => m.HomePageModule)
  },
  {
    path: '',
    redirectTo: 'home',
    pathMatch: 'full',

  },
  {
    path: 'register',
    loadChildren: () => import('./pages/register/register.module').then( m => m.RegisterPageModule),

  },
  {
    path: 'activation-account',
    loadChildren: () => import('./pages/activation-account/activation-account.module').then( m => m.ActivationAccountPageModule),

  },
  {
    path: 'my-book-list',
    loadChildren: () => import('./pages/my-book-list/my-book-list.module').then( m => m.MyBookListPageModule),
    canActivate:[authGuard]
  },
  {
    path: 'books',
    loadChildren: () => import('./pages/books/books.module').then( m => m.BooksPageModule),
    canActivate:[authGuard]
  },
  {
    path: 'borrowed-book-list',
    loadChildren: () => import('./pages/borrowed-book-list/borrowed-book-list.module').then( m => m.BorrowedBookListPageModule),
    canActivate:[authGuard]
  },
  {
    path: 'returned-book-list',
    loadChildren: () => import('./pages/returned-book-list/returned-book-list.module').then( m => m.ReturnedBookListPageModule),
    canActivate:[authGuard]
  },
  {
    path: 'manage-book',
    loadChildren: () => import('./pages/manage-book/manage-book.module').then( m => m.ManageBookPageModule),
    canActivate:[authGuard]
  },
  {
    path: 'selected-picture',
    loadChildren: () => import('./pages/selected-picture/selected-picture.module').then( m => m.SelectedPicturePageModule),
    canActivate:[authGuard]
  },
  {
    path: 'waiting-list',
    loadChildren: () => import('./waiting-list/waiting-list.module').then( m => m.WaitingListPageModule),
    canActivate:[authGuard]
  },
  {
    path: '**',
    redirectTo: 'home' 
  },
  
 
];

@NgModule({
  imports: [
    RouterModule.forRoot(routes, { preloadingStrategy: PreloadAllModules })
  ],
  exports: [RouterModule]
})
export class AppRoutingModule { }
