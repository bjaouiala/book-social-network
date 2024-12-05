import { Injectable } from '@angular/core';
import { Storage } from '@ionic/storage-angular';

@Injectable({
  providedIn: 'root'
})
export class TokenService {
  private tokenKey='token'
  private _storage : Storage | null =null


  constructor(private storage:Storage) { 
    this.init()
  }

  async init(){
    const storage = await this.storage.create()
    this._storage =storage
  }

  async getToken(): Promise<string | null> {
    await this.init()
    try {
      const token = await this._storage?.get(this.tokenKey); 
      if (!token) {
        console.warn('Token is not found in storage');
      } else {
        console.log('Token retrieved:', token);
      }
      return token || null;
    } catch (error) {
      console.error('Error retrieving token:', error);
      return null; 
    }
  }

  async setToken(token: string): Promise<void> {
    try {
      if (token) {
        await this.storage.set(this.tokenKey, token);
        console.log('Token stored:', token);
      } else {

        await this.storage.remove(this.tokenKey);
        console.log('Token removed');
      }
    } catch (error) {
      console.error('Error storing token:', error);
    }
  }
}
