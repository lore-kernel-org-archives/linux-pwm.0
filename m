From: Jingoo Han <jg1.han@samsung.com>
Subject: Re: [PATCH 14/16] backlight: atmel-pwm-bl: remove obsolete driver
Date: Fri, 21 Mar 2014 09:51:16 +0900
Message-ID: <000101cf449f$aa609960$ff21cc20$%han@samsung.com>
References: <1395234209-15546-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1395234209-15546-15-git-send-email-alexandre.belloni@free-electrons.com>
 <20140319142231.GF20872@samfundet.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20140319142231.GF20872@samfundet.no>
Content-language: ko
Sender: linux-kernel-owner@vger.kernel.org
To: 'Hans-Christian Egtvedt' <egtvedt@samfundet.no>, 'Alexandre Belloni' <alexandre.belloni@free-electrons.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 'Nicolas Ferre' <nicolas.ferre@atmel.com>, 'Jean-Christophe Plagniol-Villard' <plagnioj@jcrosoft.com>, 'Haavard Skinnemoen' <hskinnemoen@gmail.com>, 'Bryan Wu' <cooloney@gmail.com>, 'Richard Purdie' <rpurdie@rpsys.net>, 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>, 'Thierry Reding' <thierry.reding@gmail.com>, linux-leds@vger.kernel.org, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>
List-Id: linux-pwm@vger.kernel.org

On Wednesday, March 19, 2014 11:23 PM, Hans-Christian Egtvedt wrote:
> Around Wed 19 Mar 2014 14:03:27 +0100 or thereabout, Alexandre Belloni wrote:
> > The atmel-pwm-bl driver is now obsolete. It is not used by any mainlined boards
> > and is replaced by the generic pwm_bl with the pawm-atmel driver using the
> > generic PWM framework.
> >
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> 
> Acked-by: Hans-Christian Egtvedt <egtvedt@samfundet.no>

Acked-by: Jingoo Han <jg1.han@samsung.com>

Best regards,
Jingoo Han

> 
> > ---
> >  drivers/video/backlight/Kconfig        |  11 --
> >  drivers/video/backlight/Makefile       |   1 -
> >  drivers/video/backlight/atmel-pwm-bl.c | 223 ---------------------------------
> >  include/linux/atmel-pwm-bl.h           |  43 -------
> >  4 files changed, 278 deletions(-)
> >  delete mode 100644 drivers/video/backlight/atmel-pwm-bl.c
> >  delete mode 100644 include/linux/atmel-pwm-bl.h
