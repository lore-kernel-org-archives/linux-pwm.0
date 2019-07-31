From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v6 36/57] pwm: Remove dev_err() usage after
 platform_get_irq()
Date: Wed, 31 Jul 2019 09:13:01 +0200
Message-ID: <20190731071301.GA23317@kroah.com>
References: <20190730181557.90391-1-swboyd@chromium.org>
 <20190730181557.90391-37-swboyd@chromium.org>
 <20190731065853.3ohrhqtjtuhxfq5r@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190731065853.3ohrhqtjtuhxfq5r@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Stephen Boyd <swboyd@chromium.org>, linux-kernel@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On Wed, Jul 31, 2019 at 08:58:53AM +0200, Uwe Kleine-König wrote:
> On Tue, Jul 30, 2019 at 11:15:36AM -0700, Stephen Boyd wrote:
> > We don't need dev_err() messages when platform_get_irq() fails now that
> > platform_get_irq() prints an error message itself when something goes
> > wrong. Let's remove these prints with a simple semantic patch.
> 
> Looking at v5.3-rc2 it's not obvious to me that all error paths of
> platform_get_irq issue an error message. Do I miss something?

The commit is in my driver-core tree at the moment, so this should wait
until 5.4-rc1.  I woudn't recommend merging it in 5.3-rc as it's not a
bugfix.

thanks,

greg k-h
