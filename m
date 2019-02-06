From: Yash Shah <yash.shah@sifive.com>
Subject: Re: [PATCH v5 1/2] pwm: sifive: Add DT documentation for SiFive PWM Controller
Date: Wed, 6 Feb 2019 16:18:47 +0530
Message-ID: <CAJ2_jOHiJ3X5VYZMCNk2bpvUdDOsrqHJna3HPvtdNQpJB9fxjg@mail.gmail.com>
References: <1548762199-7065-1-git-send-email-yash.shah@sifive.com>
 <1548762199-7065-2-git-send-email-yash.shah@sifive.com> <20190130081411.5rva7cpwoy2l5qjd@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190130081411.5rva7cpwoy2l5qjd@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Palmer Dabbelt <palmer@sifive.com>, linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org, Thierry Reding <thierry.reding@gmail.com>, robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Sachin Ghadi <sachin.ghadi@sifive.com>, Paul Walmsley <paul.walmsley@sifive.com>
List-Id: linux-pwm@vger.kernel.org

On Wed, Jan 30, 2019 at 1:44 PM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> On Tue, Jan 29, 2019 at 05:13:18PM +0530, Yash Shah wrote:
> > DT documentation for PWM controller added.
> >
> > Signed-off-by: Wesley W. Terpstra <wesley@sifive.com>
> > [Atish: Compatible string update]
> > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > Signed-off-by: Yash Shah <yash.shah@sifive.com>
> > ---
> >  .../devicetree/bindings/pwm/pwm-sifive.txt         | 33 ++++++++++++++=
++++++++
> >  1 file changed, 33 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sifive.tx=
t
> >
> > diff --git a/Documentation/devicetree/bindings/pwm/pwm-sifive.txt b/Doc=
umentation/devicetree/bindings/pwm/pwm-sifive.txt
> > new file mode 100644
> > index 0000000..8dcb40d
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pwm/pwm-sifive.txt
> > @@ -0,0 +1,33 @@
> > +SiFive PWM controller
> > +
> > +Unlike most other PWM controllers, the SiFive PWM controller currently=
 only
> > +supports one period for all channels in the PWM. This is set globally =
in DTS.
>
> You can simply drop this if the first user can set this using the usual
> interface. Don't you like this suggestion that I already made a few
> times now?
>
> Did you consider to make the driver support only a single output with a
> more flexible period setting?

We cannot consider supporting only single output since we have boards that
use the additional PWM channels to control individual LED brightness
of a tri-color LED.
If we go down to one channel, then we can't control the brightness of
the individual LEDs.
It will break the use case.

I am considering the below approach, let me know if it's fine by you.

- Drop the global period property and allow the only first user to change p=
eriod
using the usual interface.
- A note in the binding that all PWMs need to run at the same
period. If the driver already refuses to apply incompatible periods,
the users are going to notice that they've got the DT wrong.
- In driver code, count the users using the .request and .free callbacks.
Based on this, allow changes to period iff the user count is one.

>
> > +The period also has significant restrictions on the values it can achi=
eve,
> > +which the driver rounds to the nearest achievable frequency.
>
> Rounding a period to a frequency sounds wrong.
>
> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  =
|
