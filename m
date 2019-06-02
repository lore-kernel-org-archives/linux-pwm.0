From: Sean Young <sean@mess.org>
Subject: Re: [PATCH] pwm: bcm2835: increase precision of pwm
Date: Sun, 2 Jun 2019 21:03:18 +0100
Message-ID: <20190602200318.ymyewngns745m2vx@gofer.mess.org>
References: <20190602102350.zzwmfvlky3mnlqln@gofer.mess.org>
 <0e6eef35-244a-4d52-2d87-e8ff22355f09@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <0e6eef35-244a-4d52-2d87-e8ff22355f09@gmx.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Stefan Wahren <wahrenst@gmx.net>
Cc: linux-pwm@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, Scott Branden <sbranden@broadcom.com>, Andreas Christ <andreas@christ-faesch.ch>, Ray Jui <rjui@broadcom.com>, Eric Anholt <eric@anholt.net>, Thierry Reding <thierry.reding@gmail.com>, bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

Hi Stefan,

On Sun, Jun 02, 2019 at 06:45:44PM +0200, Stefan Wahren wrote:
> Am 02.06.19 um 12:23 schrieb Sean Young:
> > If sending IR with carrier of 455kHz using the pwm-ir-tx driver, the
> > carrier ends up being 476kHz.
> >
> > A carrier of 455kHz has a period of 2198ns, but the arithmetic truncates
> > this to 2.1ns rather than 2.2ns. So, use DIV_ROUND_CLOSEST() to reduce
> > rounding errors, and we have a much more accurate carrier of 454.5kHz.
> >
> > Reported-by: Andreas Christ <andreas@christ-faesch.ch>
> > Signed-off-by: Sean Young <sean@mess.org>
> > ---
> >  drivers/pwm/pwm-bcm2835.c | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/pwm/pwm-bcm2835.c b/drivers/pwm/pwm-bcm2835.c
> > index 5652f461d994..edb2387c49a2 100644
> > --- a/drivers/pwm/pwm-bcm2835.c
> > +++ b/drivers/pwm/pwm-bcm2835.c
> > @@ -63,14 +63,14 @@ static int bcm2835_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
> >  {
> >  	struct bcm2835_pwm *pc = to_bcm2835_pwm(chip);
> >  	unsigned long rate = clk_get_rate(pc->clk);
> > -	unsigned long scaler;
> > +	unsigned int scaler;
> according to the commit log i wouldn't expect this change. Maybe it's
> worth to mention.

Yes, you are right, that needs explaining. I am trying to avoid an
unnecessary 64 bit division. I'll roll a v2.


Sean
