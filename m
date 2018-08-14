From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [RFC PATCH 0/7] add at91sam9 LCDC DRM driver
Date: Tue, 14 Aug 2018 18:16:05 +0200
Message-ID: <20180814161605.GA12387@ravnborg.org>
References: <20180812184152.GA22343@ravnborg.org>
 <f1f2a2d7-ae27-87af-8041-93d3f8fe07cc@microchip.com>
 <20180813181808.GA2357@ravnborg.org>
 <20180814143603.GO943@piout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20180814143603.GO943@piout.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, Joshua Henderson <joshua.henderson@microchip.com>, dri-devel@lists.freedesktop.org, Boris Brezillon <boris.brezillon@bootlin.com>, Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

On Tue, Aug 14, 2018 at 04:36:03PM +0200, Alexandre Belloni wrote:
> On 13/08/2018 20:18:08+0200, Sam Ravnborg wrote:
> > > Would be good to have a plan to phase-out the old atmel_lcdfb fbdev
> > > driver when this one addresses some TODO items that make sense.
> > Agree on this.
> > One approach could be to say that when all in-kernel users of atmel_lcdfb
> > are ported, then the old driver could be dropped after a kernel release.
> > 
> 
> I would drop it only after an LTS release.
Much better, agreed.

> 
> > > The mfd suffix seems strange to me. What about "atmel,at91sam9263-lcdc-mfd"
> > > => "atmel,at91sam9263-lcd" (or "microchip,at91sam9263-lcdc").
> > The "-mfd" suffix was added to avoid clashing with the current
> > compatible string used by the atmel_lcdfb driver.
> > 
> > I susggest we do the following:
> > - use the microchip prefix, as this is now owned by microchip
> > - and add the driver to a drm/microchip/ directory
> > (Then we can only hope that microchip do not change name or
> > are purchased by someone else).
> > 
> 
> The compatible string should remain the same but the drivers have to be
> mutually exclusive in Kconfig.
OK, will do so in v2.
I had planned to keep both in the DT file but then I will just replace one with the other.

	Sam
