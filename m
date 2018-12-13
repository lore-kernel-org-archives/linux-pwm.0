From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 3/3] pwm: imx: Implement get_state() function for
 hardware readout
Date: Thu, 13 Dec 2018 09:52:13 +0100
Message-ID: <20181213085213.7k5ihn7bdrtess3g@pengutronix.de>
References: <1538403588-68850-1-git-send-email-michal.vokac@ysoft.com>
 <1538403588-68850-3-git-send-email-michal.vokac@ysoft.com>
 <20181212105432.GD17654@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181212105432.GD17654@ulmo>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On Wed, Dec 12, 2018 at 11:54:32AM +0100, Thierry Reding wrote:
> On Mon, Oct 01, 2018 at 04:19:48PM +0200, Michal Vokáč wrote:
> > Implement the get_state() function and set the initial state to reflect
> > real state of the hardware. This allows to keep the PWM running if it was
> > enabled in bootloader. It is very similar to the GPIO behavior. GPIO pin
> > set as output in bootloader keep the same setting in Linux unless it is
> > reconfigured.
> > 
> > If we find the PWM block enabled we need to prepare and enable its source
> > clock otherwise the clock will be disabled late in the boot as unused.
> > That will leave the PWM in enabled state but with disabled clock. That has
> > a side effect that the PWM output is left at its current level at which
> > the clock was disabled. It is totally non-deterministic and it may be LOW
> > or HIGH.
> > 
> > Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
> > ---
> >  drivers/pwm/pwm-imx.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 53 insertions(+)
> 
> Applied, thanks.

Did you miss my feedback for this patch or did you choose to ignore it?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
