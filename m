From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 0/3] pwm: bcm2835: Minor fixes
Date: Sat, 24 Aug 2019 12:56:14 +0200
Message-ID: <20190824105614.wpkvqqxjey6umhrs@pengutronix.de>
References: <1566630445-4599-1-git-send-email-wahrenst@gmx.net>
 <20190824092553.j4rjpzaz4m6yaa5t@pengutronix.de>
 <22f8e65b-2d65-84e7-de50-ba6538a84292@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <22f8e65b-2d65-84e7-de50-ba6538a84292@gmx.net>
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
Cc: linux-pwm@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, Scott Branden <sbranden@broadcom.com>, Ray Jui <rjui@broadcom.com>, Eric Anholt <eric@anholt.net>, Thierry Reding <thierry.reding@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

Hello Stefan,

On Sat, Aug 24, 2019 at 12:05:00PM +0200, Stefan Wahren wrote:
> Am 24.08.19 um 11:25 schrieb Uwe Kleine-K=F6nig:
> > Hello Stefan,
> >
> > On Sat, Aug 24, 2019 at 09:07:22AM +0200, Stefan Wahren wrote:
> >> This small patch series contains minor fixes for clock handling and the
> >> period range check.
> >
> > I'd like to understand the various different usecases of PWMs. The
> > in-kernel consumers are kind of obvious, but sysfs users are not. It
> > seems you are one of the latter.
> >
> > Would you mind sharing what you control using the PWM?
> =

> not really a PWM user with BCM2835. It's more the motivation as a
> platform maintainer to keep the drivers in shape. At work we are using
> sysfs interface for user applications to control ventilation (via hwmon
> interface) and EV charging (IEC 61851) with a different SoC.

I don't understand how you use the sysfs interface and still interact
with the hwmon interface. Other than that, thanks for sharing.


> > Assuming you have some interest in this driver: It still uses the legacy
> > stuff implementing .config, .enable, .disable, .set_polarity. Are you
> > willing to test (or even implement) a switch to .apply instead?
> =

> Yes, definitely. This is one of my never ending TODO list [1]. But i
> would be suprised that you wont have access to a Raspberry Pi.

So be surprised :-)

> > Just from a quick lock into the driver I wonder a few things, maybe you
> > can shed some light here. If there is publicly available documenation
> > for this piece of hardware, feel free to point this out, then I might be
> > able to work out some of the answers myself.
> =

> Fortunately yes [2]

Care to add a link to this document in the driver for others to easily
find it?

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
