From: Yash Shah <yash.shah@sifive.com>
Subject: Re: [PATCH v4 1/2] pwm: sifive: Add DT documentation for SiFive PWM Controller
Date: Thu, 24 Jan 2019 14:28:44 +0530
Message-ID: <CAJ2_jOFMDkAv44Ck1HNxDQ8mfH=Zi3cxhLugoqBMDcueDw0O3w@mail.gmail.com>
References: <1548066043-1252-1-git-send-email-yash.shah@sifive.com>
 <1548066043-1252-2-git-send-email-yash.shah@sifive.com> <20190121145901.GA7547@bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190121145901.GA7547@bogus>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Palmer Dabbelt <palmer@sifive.com>, linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org, Thierry Reding <thierry.reding@gmail.com>, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Sachin Ghadi <sachin.ghadi@sifive.com>, Paul Walmsley <paul.walmsley@sifive.com>
List-Id: linux-pwm@vger.kernel.org

On Mon, Jan 21, 2019 at 8:29 PM Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Jan 21, 2019 at 03:50:42PM +0530, Yash Shah wrote:
> > DT documentation for PWM controller added.
> >
> > Signed-off-by: Wesley W. Terpstra <wesley@sifive.com>
> > [Atish: Compatible string update]
> > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > Signed-off-by: Yash Shah <yash.shah@sifive.com>
> > ---
> >  .../devicetree/bindings/pwm/pwm-sifive.txt         | 37 ++++++++++++++++++++++
> >  1 file changed, 37 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sifive.txt
> >
> > diff --git a/Documentation/devicetree/bindings/pwm/pwm-sifive.txt b/Documentation/devicetree/bindings/pwm/pwm-sifive.txt
> > new file mode 100644
> > index 0000000..b207908
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pwm/pwm-sifive.txt
> > @@ -0,0 +1,37 @@
> > +SiFive PWM controller
> > +
> > +Unlike most other PWM controllers, the SiFive PWM controller currently only
> > +supports one period for all channels in the PWM. This is set globally in DTS.
> > +The period also has significant restrictions on the values it can achieve,
> > +which the driver rounds to the nearest achievable frequency.
> > +
> > +Required properties:
> > +- compatible: Should be "sifive,pwmX" and "sifive,$socname-pwm".
>
> The order here is wrong.

Will fix the order.

>
> You still need to enumeration valid version numbers. Is 'sifive,pwm20'
> valid?

Yes

>
> > +  Please refer to sifive-blocks-ip-versioning.txt for details.
> > +- reg: physical base address and length of the controller's registers
> > +- clocks: Should contain a clock identifier for the PWM's parent clock.
> > +- #pwm-cells: Should be 2.
> > +  Refer to bindings/pwm/pwm.txt for details.
> > +- sifive,period-ns: the driver will get as close to this period as it can
> > +- interrupts: one interrupt per PWM channel
>
> How many channels? If variable, is the a max number?

Max 4 channels.

>
> > +
> > +PWM RTL that corresponds to the IP block version numbers can be found
> > +here:
> > +
> > +https://github.com/sifive/sifive-blocks/tree/master/src/main/scala/devices/pwm
>
> Put this in the description at the top.

Sure.

>
> > +
> > +Further information on the format of the IP
> > +block-specific version numbers can be found in
> > +Documentation/devicetree/bindings/sifive/sifive-blocks-ip-versioning.txt
>
> You already said this.

Will remove redundant info.

>
> > +
> > +Examples:
> > +
> > +pwm:  pwm@10020000 {
> > +     compatible = "sifive,fu540-c000-pwm","sifive,pwm0";
>
> Space after the ',' needed.

Sure

>
> > +     reg = <0x0 0x10020000 0x0 0x1000>;
> > +     clocks = <&tlclk>;
> > +     interrupt-parent = <&plic>;
> > +     interrupts = <42 43 44 45>;
> > +     #pwm-cells = <2>;
> > +     sifive,period-ns = <1000000>;
> > +};
> > --
> > 1.9.1
> >

Thanks for the feedback
