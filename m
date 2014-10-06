From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH v7 10/11] ARM: at91/dt: add LCD panel description to
 sama5d3xdm.dtsi
Date: Mon, 6 Oct 2014 15:11:11 +0200
Message-ID: <20141006151111.446ed7d6@bbrezillon>
References: <1412175188-28278-1-git-send-email-boris.brezillon@free-electrons.com>
 <1412175188-28278-11-git-send-email-boris.brezillon@free-electrons.com>
 <20141006110115.GH25202@ulmo> <20141006142538.76d2df29@bbrezillon>
 <20141006124014.GD26833@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20141006124014.GD26833@ulmo>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Lee Jones <lee.jones@linaro.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Kumar Gala <galak@codeaurora.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Andrew Victor <linux@maxim.org.za>, linux-arm-kernel@lists.infradead.org, Mark Yao <mark.yao@rock-chips.com>
List-Id: linux-pwm@vger.kernel.org

On Mon, 6 Oct 2014 14:40:15 +0200
Thierry Reding <thierry.reding@gmail.com> wrote:

> On Mon, Oct 06, 2014 at 02:25:38PM +0200, Boris Brezillon wrote:
> > On Mon, 6 Oct 2014 13:01:16 +0200 Thierry Reding <thierry.reding@gmail.com> wrote:
> > > On Wed, Oct 01, 2014 at 04:53:07PM +0200, Boris Brezillon wrote:
> > > [...]
> > > > diff --git a/arch/arm/boot/dts/sama5d3xdm.dtsi b/arch/arm/boot/dts/sama5d3xdm.dtsi
> [...]
> > > > +		backlight = <&backlight>;
> > > > +		power-supply = <&panel_reg>;
> > > > +		#address-cells = <1>;
> > > > +		#size-cells = <0>;
> > > > +		status = "disabled";
> > > > +
> > > > +		port@0 {
> > > > +			#address-cells = <1>;
> > > > +			#size-cells = <0>;
> > > > +
> > > > +			panel_input: endpoint@0 {
> > > > +				reg = <0>;
> > > > +				remote-endpoint = <&hlcdc_panel_output>;
> > > > +			};
> > > >  		};
> > > 
> > > There's no support for OF graphs in simple-panel, so this is unused,
> > > isn't it?
> > 
> > Actually I use it in my atmel_hlcdc_ouput implementation to figure out
> > the link between a panel and a device connected on the RGB/DPI bus. 
> 
> That's kind of weird and one of the reasons why I can't make myself like
> the OF graph bindings. It requires drivers for one device to reach into
> the device tree node of some other device and look for content. Or put
> another way, a DT node for a panel that works on one platform doesn't
> work on another because the display controller needs additional DT
> content that isn't required by the original binding for the panel.

I also have a working POC of a DPI bus implementation (with DPI support
in panel-simple driver).

This is a solution I developed to provide a generic DPI implementation
in my HLCDC driver and rely on generic external implementations for
slave devices (panels, encoders, ...).

But, IIRC, Laurent was not in favor of a bus approach because the DPI
bus is just a data bus and not a control bus.

Anyway, I'll clean it up and post an RFC.

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
