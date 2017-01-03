From: Sylvain Lemieux <slemieux.tyco@gmail.com>
Subject: Re: [PATCH 1/3] dt: pwm: lpc32xx: add description of clocks and
 #pwm-cells properties
Date: Tue, 03 Jan 2017 10:22:00 -0500
Message-ID: <1483456920.7643.1.camel@localhost>
References: <20161205014237.1689-1-vz@mleia.com>
 <20161205014237.1689-2-vz@mleia.com>
 <20161209214137.2hdugl5rmnwjrus4@rob-hp-laptop>
 <015305d5-c22f-52da-9605-f2c19e3108b1@mleia.com>
 <5a865e27-e673-2f45-6c71-ca1e7d92a346@mleia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <5a865e27-e673-2f45-6c71-ca1e7d92a346@mleia.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Vladimir Zapolskiy <vz@mleia.com>
Cc: Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Hi Rob,

On Wed, 2016-12-21 at 05:30 +0200, Vladimir Zapolskiy wrote:
> On 12/10/2016 01:51 AM, Vladimir Zapolskiy wrote:
> > Hi Rob,
> > 
> > On 12/09/2016 11:41 PM, Rob Herring wrote:
> >> On Mon, Dec 05, 2016 at 03:42:37AM +0200, Vladimir Zapolskiy wrote:
> >>> NXP LPC32xx SoCs have two simple independent PWM controllers with a single
> >>> output each, in this case there is no need to specify PWM channel argument
> >>> on client side, one cell for setting PWM output frequency is sufficient.
> >>>
> >>> Another added to the description property 'clocks' has a standard meaning
> >>> of a controller supply clock, in the LPC32xx User's Manual the clock is
> >>> denoted as PWM1_CLK or PWM2_CLK clock.
> >>>
> >>> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
> >>> ---
> >>>  Documentation/devicetree/bindings/pwm/lpc32xx-pwm.txt | 7 +++++++
> >>>  1 file changed, 7 insertions(+)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/pwm/lpc32xx-pwm.txt b/Documentation/devicetree/bindings/pwm/lpc32xx-pwm.txt
> >>> index 74b5bc5..523d796 100644
> >>> --- a/Documentation/devicetree/bindings/pwm/lpc32xx-pwm.txt
> >>> +++ b/Documentation/devicetree/bindings/pwm/lpc32xx-pwm.txt
> >>> @@ -3,15 +3,22 @@ LPC32XX PWM controller
> >>>  Required properties:
> >>>  - compatible: should be "nxp,lpc3220-pwm"
> >>>  - reg: physical base address and length of the controller's registers
> >>> +- clocks: clock phandle and clock specifier pair
> >>> +- #pwm-cells: should be 1, the cell is used to specify the period in
> >>> +  nanoseconds.
> >>
> >> This use of the cell is a bit odd as the period is s/w config and this 
> >> would typically be a channel selection or such.
> > 
> > this is a classic PWM channel configuration property for PWM consumers
> > described in DT, for instance PWM frequency for display panel backlight
> > on boot.
> > 
> > I think >90% of PWM controllers with device tree bindings have this
> > argument in #pwm-cells, from bindings/pwm/pwm.txt :
> > 
> >     pwm-specifier typically encodes the chip-relative PWM number and
> >     the PWM period in nanoseconds.
> > 
> > You also may skim through phandle arguments of 'pwms' property,
> > commonly the second argument is the requested frequency.
> > 
> > In this particular case I just drop PWM channel number, because
> > the LPC32xx PWM controller has a single output channel.
> > 
> >> What if I want user specified/changed periods?
> >>
> > 
> > The preset period still can be changed over sysfs in runtime.
> 
> Rob, have I managed to answer your questions?
> 
> If you accept my clarification, could you please ack the change?
> 
> --
> With best wishes,
> Vladimir
> 
ping

Sylvain
