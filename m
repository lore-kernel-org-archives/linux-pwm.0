From: Clemens Gruber <clemens.gruber@pqgruber.com>
Subject: Re: [PATCH 2/4] pwm: pca9685: remove ALL_LED PWM channel
Date: Mon, 30 Mar 2020 15:34:50 +0200
Message-ID: <20200330133450.GA1530@workstation.tuxnet>
References: <20200226135229.24929-1-matthias.schiffer@ew.tq-group.com>
 <20200226135229.24929-2-matthias.schiffer@ew.tq-group.com>
 <20200330130757.GC2431644@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200330130757.GC2431644@ulmo>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com
List-Id: linux-pwm@vger.kernel.org

Hi,

On Mon, Mar 30, 2020 at 03:07:57PM +0200, Thierry Reding wrote:
> On Wed, Feb 26, 2020 at 02:52:27PM +0100, Matthias Schiffer wrote:
> > The interaction of the ALL_LED PWM channel with the other channels was
> > not well-defined. As the ALL_LED feature does not seem very useful and
> > it was making the code significantly more complex, simply remove it.
> > 
> > Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> > ---
> >  drivers/pwm/pwm-pca9685.c | 115 ++++++--------------------------------
> >  1 file changed, 17 insertions(+), 98 deletions(-)
> 
> Applied, thanks.
> 
> Thierry

I was not reading the mailing list in the last weeks, so I only saw the
patch today.

We are using the ALL_LED channel in production to reduce the delay when
all 16 PWM outputs need to be set to the same duty cycle.

I am not sure it is a good idea to remove this feature.

Best regards,
Clemens
