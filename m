From: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v2 4/7] dt-bindings: counter: ftm-quaddec
Date: Sat, 16 Mar 2019 14:21:38 +0000
Message-ID: <20190316142138.65860d88@archlinux>
References: <20190306111208.7454-1-patrick.havelange@essensium.com>
        <20190306111208.7454-5-patrick.havelange@essensium.com>
        <20190312190952.GA18547@bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190312190952.GA18547@bogus>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Patrick Havelange <patrick.havelange@essensium.com>, William Breathitt Gray <vilhelm.gray@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Thierry Reding <thierry.reding@gmail.com>, Esben Haabendal <esben@haabendal.dk>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: linux-pwm@vger.kernel.org

On Tue, 12 Mar 2019 14:09:52 -0500
Rob Herring <robh@kernel.org> wrote:

> On Wed, Mar 06, 2019 at 12:12:05PM +0100, Patrick Havelange wrote:
> > FlexTimer quadrature decoder driver.
> > 
> > Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
> > Reviewed-by: Esben Haabendal <esben@haabendal.dk>
> > ---
> > Changes v2
> >      - None
> > ---
> >  .../bindings/counter/ftm-quaddec.txt           | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/counter/ftm-quaddec.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/counter/ftm-quaddec.txt b/Documentation/devicetree/bindings/counter/ftm-quaddec.txt
> > new file mode 100644
> > index 000000000000..4d18cd722074
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/counter/ftm-quaddec.txt
> > @@ -0,0 +1,18 @@
> > +FlexTimer Quadrature decoder counter
> > +
> > +This driver exposes a simple counter for the quadrature decoder mode.  
> 
> Seems like this is more a mode of a h/w block than describing a h/w 
> block. Bindings should do the latter.
The snag is that we need to dig ourselves out of the hole set by:
fsl,vf610-ftm-pwm etc.

Documentation/devicetree/bindings/pwm/pwm-fsl-ftm.txt
Documentation/devicetree/bindings/timer/fsl,ftm-timer.txt
(I'm assuming these are the same IP block).

Can probably be sorted out though.  One core driver binds against the
ftm and deals with instantiating the others depending on the configuration
(note that this mode for instance does make sense in DT as it's
really reflecting the fact there is a quadrature encoder
connected to the ftm).

Fiddly though :)

J
> 
> > +
> > +Required properties:
> > +- compatible:		Must be "fsl,ftm-quaddec".
> > +- reg:			Must be set to the memory region of the flextimer.
> > +
> > +Optional property:
> > +- big-endian:		Access the device registers in big-endian mode.
> > +
> > +Example:
> > +		counter0: counter@29d0000 {
> > +			compatible = "fsl,ftm-quaddec";
> > +			reg = <0x0 0x29d0000 0x0 0x10000>;
> > +			big-endian;
> > +			status = "disabled";
> > +		};
> > -- 
> > 2.19.1
> >   
