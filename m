From: Yash Shah <yash.shah@sifive.com>
Subject: Re: [RFC v2 1/2] pwm: sifive: Add DT documentation for SiFive PWM Controller
Date: Fri, 4 Jan 2019 10:33:36 +0530
Message-ID: <CAJ2_jOEy-0DmkzoOwezUf3+gHV3CTu04CqG1tiw5=iX-AO8xZg@mail.gmail.com>
References: <1544768442-12530-1-git-send-email-yash.shah@sifive.com>
 <1544768442-12530-2-git-send-email-yash.shah@sifive.com> <20181218172031.GA7272@bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181218172031.GA7272@bogus>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Palmer Dabbelt <palmer@sifive.com>, linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org, Thierry Reding <thierry.reding@gmail.com>, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Sachin Ghadi <sachin.ghadi@sifive.com>, Paul Walmsley <paul.walmsley@sifive.com>
List-Id: linux-pwm@vger.kernel.org

On Tue, Dec 18, 2018 at 10:50 PM Rob Herring <robh@kernel.org> wrote:
>
> On Fri, Dec 14, 2018 at 11:50:41AM +0530, Yash Shah wrote:
> > DT documentation for PWM controller added with updated compatible
> > string.
> >
> > Signed-off-by: Wesley W. Terpstra <wesley@sifive.com>
> > [Atish: Compatible string update]
> > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > Signed-off-by: Yash Shah <yash.shah@sifive.com>
> > ---
> >  .../devicetree/bindings/pwm/pwm-sifive.txt         | 44 ++++++++++++++++++++++
> >  1 file changed, 44 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sifive.txt
> >
> > diff --git a/Documentation/devicetree/bindings/pwm/pwm-sifive.txt b/Documentation/devicetree/bindings/pwm/pwm-sifive.txt
> > new file mode 100644
> > index 0000000..250d8ee
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pwm/pwm-sifive.txt
> > @@ -0,0 +1,44 @@
> > +SiFive PWM controller
> > +
> > +Unlike most other PWM controllers, the SiFive PWM controller currently only
> > +supports one period for all channels in the PWM. This is set globally in DTS.
> > +The period also has significant restrictions on the values it can achieve,
> > +which the driver rounds to the nearest achievable frequency.
> > +
> > +Required properties:
> > +- compatible: should be something similar to "sifive,<chip>-pwm" for
> > +           the PWM as integrated on a particular chip, and
> > +           "sifive,pwm<version>" for the general PWM IP block
> > +           programming model. Supported compatible strings are:
> > +           "sifive,fu540-c000-pwm" for the SiFive PWM v0 as
> > +           integrated onto the SiFive FU540 chip, and "sifive,pwm0"
> > +           for the SiFive PWM v0 IP block with no chip integration
> > +           tweaks.
>
> This should reference the common doc Paul has written and not re-explain
> the versioning scheme again.

Ok sure.

>
> > +- reg: physical base address and length of the controller's registers
> > +- clocks: The frequency the controller runs at
> > +- #pwm-cells: Should be 2.
> > +  The first cell is the PWM channel number
> > +  The second cell is the PWM polarity
> > +- sifive,approx-period: the driver will get as close to this period as it can
>
> Needs a unit suffix as defined in property-units.txt

Will be done.

>
> > +- interrupts: one interrupt per PWM channel
> > +
> > +PWM RTL that corresponds to the IP block version numbers can be found
> > +here:
> > +
> > +https://github.com/sifive/sifive-blocks/tree/master/src/main/scala/devices/pwm
> > +
> > +Further information on the format of the IP
> > +block-specific version numbers can be found in
> > +Documentation/devicetree/bindings/sifive/sifive-blocks-ip-versioning.txt
> > +
> > +Examples:
> > +
> > +pwm:  pwm@10020000 {
> > +     compatible = "sifive,fu540-c000-pwm","sifive,pwm0";
> > +     reg = <0x0 0x10020000 0x0 0x1000>;
> > +     clocks = <&tlclk>;
> > +     interrupt-parent = <&plic>;
> > +     interrupts = <42 43 44 45>;
> > +     #pwm-cells = <2>;
> > +     sifive,approx-period = <1000000>;
> > +};
> > --
> > 1.9.1
> >

Thanks for the comments!
