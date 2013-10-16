Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] pwm: add ep93xx PWM support
Date: Wed, 16 Oct 2013 09:24:36 +0200
References: <201310151840.03569.hartleys@visionengravers.com>
In-Reply-To: <201310151840.03569.hartleys@visionengravers.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201310160924.36639.arnd@arndb.de>
List-ID: <linux-pwm.vger.kernel.org>
To: H Hartley Sweeten <hartleys@visionengravers.com>
Cc: linux-pwm@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, Ryan Mallon <rmallon@gmail.com>, thierry.reding@gmail.com, gregkh@linuxfoundation.org

On Wednesday 16 October 2013, H Hartley Sweeten wrote:
> Remove the non-standard EP93xx PWM driver in drivers/misc and add
> a new driver for the PWM controllers on the EP93xx platform based
> on the PWM framework.
> 
> These PWM controllers each support 1 PWM channel with programmable
> duty cycle, frequency, and polarity inversion.
> 
> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Ryan Mallon <rmallon@gmail.com>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> v2: address issues pointed out by Thierry Reding.

Looks all good from my side, thanks for taking up this work.

Acked-by: Arnd Bergmann <arnd@arndb.de>
