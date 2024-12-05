import { CanActivateFn } from '@angular/router';

import { inject } from '@angular/core';
import { Router } from '@angular/router';
import { TokenService } from './auth/token.service';

export const authGuard: CanActivateFn = async (route, state) => {
  const tokenService = inject(TokenService);
  const router = inject(Router);
  
  const token = await tokenService.getToken();

  if (token) {
    return true;
  } else {

    router.navigate(['/login']); 
    return false; 
  }
};
