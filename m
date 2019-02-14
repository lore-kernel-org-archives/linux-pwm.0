From: Yash Shah <yash.shah@sifive.com>
Subject: Re: [PATCH v6 1/2] pwm: sifive: Add DT documentation for SiFive PWM Controller
Date: Thu, 14 Feb 2019 13:37:59 +0530
Message-ID: <CAJ2_jOHwk3_5Z1=QD4HZjpWg0mx-RTKzq44gueFZQ2k2OaZOZw@mail.gmail.com>
References: <1550049978-20705-1-git-send-email-yash.shah@sifive.com>
 <1550049978-20705-2-git-send-email-yash.shah@sifive.com> <20190213203752.GA18326@bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190213203752.GA18326@bogus>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Palmer Dabbelt <palmer@sifive.com>, linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org, Thierry Reding <thierry.reding@gmail.com>, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Sachin Ghadi <sachin.ghadi@sifive.com>, Paul Walmsley <paul.walmsley@sifive.com>
List-Id: linux-pwm@vger.kernel.org

On Thu, Feb 14, 2019 at 2:07 AM Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Feb 13, 2019 at 02:56:17PM +0530, Yash Shah wrote:
> > DT documentation for PWM controller added.
> >
> > Signed-off-by: Wesley W. Terpstra <wesley@sifive.com>
> > [Atish: Compatible string update]
> > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > Signed-off-by: Yash Shah <yash.shah@sifive.com>
> > ---
> >  .../devicetree/bindings/pwm/pwm-sifive.txt         | 30 ++++++++++++++++++++++
> >  1 file changed, 30 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sifive.txt
> >
> > diff --git a/Documentation/devicetree/bindings/pwm/pwm-sifive.txt b/Documentation/devicetree/bindings/pwm/pwm-sifive.txt
> > new file mode 100644
> > index 0000000..3b9c64c
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pwm/pwm-sifive.txt
> > @@ -0,0 +1,30 @@
> > +SiFive PWM controller
> > +
> > +Unlike most other PWM controllers, the SiFive PWM controller currently only
> > +supports one period for all channels in the PWM. All PWMs need to run at
> > +the same period. The period also has significant restrictions on the values
> > +it can achieve, which the driver rounds to the nearest achievable period.
> > +PWM RTL that corresponds to the IP block version numbers can be found
> > +here:
> > +
> > +https://github.com/sifive/sifive-blocks/tree/master/src/main/scala/devices/pwm
> > +
> > +Required properties:
> > +- compatible: Should be "sifive,$socname-pwm" and "sifive,pwmX".
> > +  Please refer to sifive-blocks-ip-versioning.txt for details.
>
> Please specify what soc and IP version are used. Is sifive,pwm10 valid?

Does the below description seem fine?

should be "sifive,<chip>-pwm" and "sifive,pwm<version>".
Supported compatible strings are:
"sifive,fu540-c000-pwm" for the SiFive PWM v0 as
integrated onto the SiFive FU540 chip, and "sifive,pwm0"
for the SiFive PWM v0 IP block with no chip integration
tweaks. Please refer to sifive-blocks-ip-versioning.txt for details

>
> > +- reg: physical base address and length of the controller's registers
> > +- clocks: Should contain a clock identifier for the PWM's parent clock.
> > +- #pwm-cells: Should be 3. See pwm.txt in this directory
> > +  for a description of the cell format.
> > +- interrupts: one interrupt per PWM channel
> > +
> > +Examples:
> > +
> > +pwm:  pwm@10020000 {
> > +     compatible = "sifive,fu540-c000-pwm", "sifive,pwm0";
> > +     reg = <0x0 0x10020000 0x0 0x1000>;
> > +     clocks = <&tlclk>;
> > +     interrupt-parent = <&plic>;
> > +     interrupts = <42 43 44 45>;
> > +     #pwm-cells = <3>;
> > +};
> > --
> > 1.9.1
> >

Thanks for the comment
