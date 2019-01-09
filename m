From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: Handle pwm with sysfs with recent kernel
Date: Wed, 9 Jan 2019 10:20:06 +0100
Message-ID: <20190109092006.35364dwcfiindd7c@pengutronix.de>
References: <20190108100739.GA9046@arthur-bzh>
 <20190108222102.hwv5oekspifhj7bh@pengutronix.de>
 <20190109092531.71cf52c8@karo-electronics.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190109092531.71cf52c8@karo-electronics.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>, Arthur LAMBERT <lambertarthur22@gmail.com>
Cc: linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

Hello,

On Wed, Jan 09, 2019 at 09:25:31AM +0100, Lothar Wa=DFmann wrote:
> Hi,
> =

> On Tue, 8 Jan 2019 23:21:02 +0100 Uwe Kleine-K=F6nig wrote:
> > On Tue, Jan 08, 2019 at 11:07:39AM +0100, Arthur LAMBERT wrote:
> > > Then I have another issue when I try to enable my pwm :
> > > =

> > > # ls /sys/class/pwm/
> > > pwmchip0  pwmchip2  pwmchip4  pwmchip6
> > > pwmchip1  pwmchip3  pwmchip5  pwmchip7
> > > # echo 0 > /sys/class/pwm/pwmchip0/export
> > > # echo 1 > /sys/class/pwm/pwmchip0/pwm0/enable
> > > -sh: write error: Invalid argument  =

> > =

> > Just a guess: did you check that /sys/class/pwm/pwmchip0/pwm0/enable
> > actually exists?
> > =

> If not, the error message would be 'No such file or directory' rather
> than "Invalid argument".

Then "Invalid argument" means that either the "1" couldn't be parsed as
an integer 1 or 0 (no) or that pwm_apply_state returned -EINVAL. What
type of pwm are we talking about (i.e. which driver is responsible for
pwmchip0)? Hmm, that machine is an imx6ul, looking at the pwm-imx driver
there doesn't seem to be a path through the .apply callback that returns
-EINVAL. Would you care to add a few printk in
drivers/pwm/sysfs.c:enable_store() that show where the -EINVAL comes
from?

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
