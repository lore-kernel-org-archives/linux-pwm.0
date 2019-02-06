From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v5 1/2] pwm: sifive: Add DT documentation for SiFive PWM
 Controller
Date: Wed, 6 Feb 2019 16:38:54 +0100
Message-ID: <20190206153854.52bqbwf2ty2j7rvj@pengutronix.de>
References: <1548762199-7065-1-git-send-email-yash.shah@sifive.com>
 <1548762199-7065-2-git-send-email-yash.shah@sifive.com>
 <20190130081411.5rva7cpwoy2l5qjd@pengutronix.de>
 <CAJ2_jOHiJ3X5VYZMCNk2bpvUdDOsrqHJna3HPvtdNQpJB9fxjg@mail.gmail.com>
 <20190206110730.ogqxncrnblyazgjw@pengutronix.de>
 <20190206124055.GF21676@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190206124055.GF21676@ulmo>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Yash Shah <yash.shah@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org, robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Sachin Ghadi <sachin.ghadi@sifive.com>, Paul Walmsley <paul.walmsley@sifive.com>
List-Id: linux-pwm@vger.kernel.org

On Wed, Feb 06, 2019 at 01:40:55PM +0100, Thierry Reding wrote:
> On Wed, Feb 06, 2019 at 12:07:30PM +0100, Uwe Kleine-König wrote:
> > On Wed, Feb 06, 2019 at 04:18:47PM +0530, Yash Shah wrote:
> > > On Wed, Jan 30, 2019 at 1:44 PM Uwe Kleine-König
> > > <u.kleine-koenig@pengutronix.de> wrote:
> > > >
> > > > On Tue, Jan 29, 2019 at 05:13:18PM +0530, Yash Shah wrote:
> > > > > DT documentation for PWM controller added.
> > > > >
> > > > > Signed-off-by: Wesley W. Terpstra <wesley@sifive.com>
> > > > > [Atish: Compatible string update]
> > > > > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > > > > Signed-off-by: Yash Shah <yash.shah@sifive.com>
> > > > > ---
> > > > >  .../devicetree/bindings/pwm/pwm-sifive.txt         | 33 ++++++++++++++++++++++
> > > > >  1 file changed, 33 insertions(+)
> > > > >  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sifive.txt
> > > > >
> > > > > diff --git a/Documentation/devicetree/bindings/pwm/pwm-sifive.txt b/Documentation/devicetree/bindings/pwm/pwm-sifive.txt
> > > > > new file mode 100644
> > > > > index 0000000..8dcb40d
> > > > > --- /dev/null
> > > > > +++ b/Documentation/devicetree/bindings/pwm/pwm-sifive.txt
> > > > > @@ -0,0 +1,33 @@
> > > > > +SiFive PWM controller
> > > > > +
> > > > > +Unlike most other PWM controllers, the SiFive PWM controller currently only
> > > > > +supports one period for all channels in the PWM. This is set globally in DTS.
> > > >
> > > > You can simply drop this if the first user can set this using the usual
> > > > interface. Don't you like this suggestion that I already made a few
> > > > times now?
> > > >
> > > > Did you consider to make the driver support only a single output with a
> > > > more flexible period setting?
> > > 
> > > We cannot consider supporting only single output since we have boards that
> > > use the additional PWM channels to control individual LED brightness
> > > of a tri-color LED.
> > > If we go down to one channel, then we can't control the brightness of
> > > the individual LEDs.
> > > It will break the use case.
> > 
> > OK.
> > 
> > > I am considering the below approach, let me know if it's fine by you.
> > > 
> > > - Drop the global period property and allow the only first user to change period
> > > using the usual interface.
> > > - A note in the binding that all PWMs need to run at the same
> > > period. If the driver already refuses to apply incompatible periods,
> > > the users are going to notice that they've got the DT wrong.
> > > - In driver code, count the users using the .request and .free callbacks.
> > > Based on this, allow changes to period iff the user count is one.
> > 
> > Not sure you need to point this limitation in the binding doc. Other
> > than that this is fine.
> 
> I think it's useful to point this out in the binding documentation since
> it's something that device tree writers will want to know.

OK, we're talking about an FPGA implementation but I still think if the
dt-author is the first to know about this limitation this is too late.
The hardware designer must know about that, and they don't look into the
bindind documentation. The binding documentation should IMHO only
describe the binding and functional limitiations of the device are out
of scope.

The binding for the Freescale network interface doesn't describe that it
only supports 480 MBit/s in its GHz mode, and that's good. The binding
for i2c devices doesn't describe that a reboot in the middle of a
transfer might block the bus.

The target for the binding documentation is to document how a given
device is described in a device tree. It's not there to duplicate
information that belongs in the reference manual.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
