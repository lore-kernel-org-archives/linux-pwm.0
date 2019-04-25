From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 11/12] misc: atmel_tclib: do not probe already used TCBs
Date: Thu, 25 Apr 2019 22:18:48 +0200
Message-ID: <20190425201848.GA14659@kroah.com>
References: <20190403141120.32754-1-alexandre.belloni@bootlin.com>
 <20190403141120.32754-12-alexandre.belloni@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190403141120.32754-12-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Arnd Bergmann <arnd@arndb.de>, Nicolas Ferre <nicolas.ferre@microchip.com>, Alexander Dahl <ada@thorsis.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On Wed, Apr 03, 2019 at 04:11:19PM +0200, Alexandre Belloni wrote:
> The TCBs that have children are using the new (proper) DT bindings and
> don't need to be handled by tclib.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  drivers/misc/atmel_tclib.c | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
