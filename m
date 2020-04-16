From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH RFC 0/6] PWM fan support on Clearfog gt8k
Date: Thu, 16 Apr 2020 15:50:39 +0200
Message-ID: <20200416135039.GL657811@lunn.ch>
References: <20200329104549.GX25745@shell.armlinux.org.uk>
 <CACRpkdaL4-Z36aKOVW4o2MtCG9fbqm4gxZN3QjejVRPBZrzxxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdaL4-Z36aKOVW4o2MtCG9fbqm4gxZN3QjejVRPBZrzxxA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Jason Cooper <jason@lakedaemon.net>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, Gregory Clement <gregory.clement@bootlin.com>, Russell King - ARM Linux admin <linux@armlinux.org.uk>, linux-pwm@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-pwm@vger.kernel.org

On Thu, Apr 16, 2020 at 09:51:37AM +0200, Linus Walleij wrote:
> On Sun, Mar 29, 2020 at 12:46 PM Russell King - ARM Linux admin
> <linux@armlinux.org.uk> wrote:
> 
> > This series adds support for the fan PWM output on the Clearfog GT8K
> > platform, and can potentially be extended to the Macchiatobin.
> 
> The gpio changes all look fine to me +/- fixes for review comments.
> 
> Could the MVEBU maintainers provide some feedback?

Hi Linus

I took a quick look at this when it was first posted. I also wrote the
PWM support in this driver. The hardware is mostly a GPIO driver, but
it has some basic PWM facilities. It is not possible to cleanly split
it into two drivers, which is why it has the current structure. And
the PWM maintainers ask that the PWM parts be listed in MAINTAINERS as
such, so they got to know about any changes.

Clocking with Marvell devices has always been interesting. Core IP
like this gets reused between different generations of SoCs. The
original Orion5x had no clock control at all. Latter SoCs have had
more and more complex clock trees. So care has to be taken to not
change old behaviour when adding support for new clocks. So Russell
2/6 patch looks good to me, and Uwe request could break on some
SoCs. It would need testing on a lot of SoCs, with and without PWM
support. 

I assume Russell will at some point repost without the RFC tag. At
that point i will take a second look and add Reviewed-by.

     Andrew
