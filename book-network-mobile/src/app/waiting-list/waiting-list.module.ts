import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';

import { IonicModule } from '@ionic/angular';

import { WaitingListPageRoutingModule } from './waiting-list-routing.module';

import { WaitingListPage } from './waiting-list.page';
import { BooksPageModule } from "../pages/books/books.module";

@NgModule({
  imports: [
    CommonModule,
    FormsModule,
    IonicModule,
    WaitingListPageRoutingModule,
    BooksPageModule
],
  declarations: [WaitingListPage]
})
export class WaitingListPageModule {}
