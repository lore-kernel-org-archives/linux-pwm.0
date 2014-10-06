From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH v7 04/11] pwm: add DT bindings documentation for
 atmel-hlcdc-pwm driver
Date: Mon, 6 Oct 2014 14:59:12 +0200
Message-ID: <20141006145912.1e448507@bbrezillon>
References: <1412175188-28278-1-git-send-email-boris.brezillon@free-electrons.com>
 <1412175188-28278-5-git-send-email-boris.brezillon@free-electrons.com>
 <20141006101350.GD25202@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20141006101350.GD25202@ulmo>
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

On Mon, 6 Oct 2014 12:13:51 +0200
Thierry Reding <thierry.reding@gmail.com> wrote:

> On Wed, Oct 01, 2014 at 04:53:01PM +0200, Boris Brezillon wrote:
> > From: Boris BREZILLON <boris.brezillon@free-electrons.com>
> > 
> > The HLCDC IP available in some Atmel SoCs (i.e. sam9x5i.e. at91sam9n12,
> > at91sam9x5 family or sama5d3 family) provide a PWM device.
> > 
> > The DT bindings used for this PWM device is following the default 3 cells
> > bindings described in Documentation/devicetree/bindings/pwm/pwm.txt.
> > 
> > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > ---
> >  .../devicetree/bindings/pwm/atmel-hlcdc-pwm.txt    | 55 ++++++++++++++++++++++
> >  1 file changed, 55 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pwm/atmel-hlcdc-pwm.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/pwm/atmel-hlcdc-pwm.txt b/Documentation/devicetree/bindings/pwm/atmel-hlcdc-pwm.txt
> > new file mode 100644
> > index 0000000..86ad3e2
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pwm/atmel-hlcdc-pwm.txt
> > @@ -0,0 +1,55 @@
> > +Device-Tree bindings for Atmel's HLCDC (High LCD Controller) PWM driver
> > +
> > +The Atmel HLCDC PWM is subdevice of the HLCDC MFD device.
> > +See ../mfd/atmel-hlcdc.txt for more details.
> > +
> > +Required properties:
> > + - compatible: value should be one of the following:
> > +   "atmel,hlcdc-pwm"
> > + - pinctr-names: the pin control state names. Should contain "default".
> > + - pinctrl-0: should contain the pinctrl states described by pinctrl
> > +   default.
> > + - #pwm-cells: should be set to 3. This PWM chip use the default 3 cells
> > +   bindings defined in Documentation/devicetree/bindings/pwm/pwm.txt.
> > +   The first cell encodes the PWM id (0 is the only acceptable value here,
> > +   because the chip only provide one PWM).
> > +   The second cell encodes the PWM period in nanoseconds.
> > +   The third cell encodes the PWM flags (the only supported flag is
> > +   PWM_POLARITY_INVERTED)
> 
> Given that this already refers to the default 3 cells binding it doesn't
> need to repeat part of the contents of pwm.txt.
> 
> With that fixed and assuming you'd like this to be merged via the same
> tree that the DRM and or MFD driver is, this patch:
> 
> Acked-by: Thierry Reding <thierry.reding@gmail.com>
> 
> If you'd prefer this to go through the PWM tree just let me know.

Yes I'd prefer this solution, but shouldn't we wait for Lee to take the
first two patches in his tree ?



-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
