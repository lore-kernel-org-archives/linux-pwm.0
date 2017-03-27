From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v3 4/4] mvebu: wrt1900ac: Use pwm-fan rather than gpio-fan
Date: Mon, 27 Mar 2017 15:17:25 +0200
Message-ID: <20170327131725.GA25549@lunn.ch>
References: <20170324141815.7252-1-ralph.sennhauser@gmail.com>
 <20170324141815.7252-5-ralph.sennhauser@gmail.com>
 <20170324143505.GK28518@lunn.ch>
 <20170326230558.6b6c4ec6@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20170326230558.6b6c4ec6@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ralph Sennhauser <ralph.sennhauser@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Alexandre Courbot <gnurou@gmail.com>, Jason Cooper <jason@lakedaemon.net>, linux-pwm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Russell King <linux@armlinux.org.uk>, Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>, Imre Kaloz <kaloz@openwrt.org>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-pwm@vger.kernel.org

On Sun, Mar 26, 2017 at 11:05:58PM +0200, Ralph Sennhauser wrote:
> On Fri, 24 Mar 2017 15:35:05 +0100
> Andrew Lunn <andrew@lunn.ch> wrote:
> 
> > > +	pwm_fan {
> > >  		/* SUNON HA4010V4-0000-C99 */
> > > -		compatible = "gpio-fan";
> > > -		gpios = <&gpio0 24 0>;
> > >  
> > > -		gpio-fan,speed-map = <0    0
> > > -				      4500 1>;
> > > +		compatible = "pwm-fan";
> > > +		pwms = <&gpio0 24 4000 0>;  
> > 
> > Hi Ralph
> > 
> > I believe this last 0 is the flags parameter. Now that we have
> > #pwm-cells = 1, i think this last 0 should be dropped.
> > 
> > 	  Andrew
> 
> Hi Andrew,
> 
> isn't the 4000 (period?) pwm-cell #2 and 0 (flags?) pwm-cell #3? I
> actually expect "pwms = <&gpio0 24>;" here or "#pwm-cells = <2>;"

Hi Ralph

From Documentation/devicetree/bindings/pwm/pwm.txt:

        pwm-list ::= <single-pwm> [pwm-list]
        single-pwm ::= <pwm-phandle> <pwm-specifier>
        pwm-phandle : phandle to PWM controller node
        pwm-specifier : array of #pwm-cells specifying the given PWM
                        (controller specific)

Our pwm-list has a single single-pwm.
phandle is &gpio0.
The remaining parts are the specifier, or which there should be #pwm-calls.

From Documentation/devicetree/bindings/pwm/pwm.txt again:

pwm-specifier typically encodes the chip-relative PWM number and the PWM
period in nanoseconds.

Optionally, the pwm-specifier can encode a number of flags (defined in
<dt-bindings/pwm/pwm.h>) in a third cell:
- PWM_POLARITY_INVERTED: invert the PWM signal polarity

So we are using the 24th PWM and 4000 nanosecod period. We don't want
any flags.

So

pwms = <&gpio0 24 4000>;  

has a phandle, and then 2 cells.

    Andrew
