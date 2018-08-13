From: Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: Re: [RFC PATCH 0/7] add at91sam9 LCDC DRM driver
Date: Mon, 13 Aug 2018 16:47:26 +0200
Message-ID: <264d51a0-7e41-6c27-d438-9ae337e6dcf0@microchip.com>
References: <20180812184152.GA22343@ravnborg.org>
 <20180812195536.GA29811@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180812195536.GA29811@ravnborg.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sam Ravnborg <sam@ravnborg.org>, Boris Brezillon <boris.brezillon@bootlin.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Lee Jones <lee.jones@linaro.org>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Joshua Henderson <joshua.henderson@microchip.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org, linux-pwm@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On 12/08/2018 at 21:55, Sam Ravnborg wrote:
> The at91sam9263 has a few interesting "GPU" features:
> 
> - 2D memory addressing
>    Data sheet says:
> 	The LCDC can be configured to work on a frame buffer
> 	larger than the actual screen size. By changing the
> 	values in a few registers, it is easy to move the
> 	displayed area along the frame buffer width and height
> 
> - 2D Graphics controller
>    Data sheet says:
> 	The Two D Graphics Controller (TDGC) features a
> 	hardware accelerator which highly simplifies drawing
> 	tasks and graphic management operations.
> 	The hardware accelerator makes it easy to draw lines
> 	and complex polygons and to perform block transfers
> 	within the frame buffer.
> 	The TDGC also features a draw command queue that
> 	automatically executes a more complex drawing function
> 	that is composed of several register accesses.
> 
> The datasheet text is from: chapter 43.9 + chapter 44:
> http://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-6249-32-bit-ARM926EJ-S-Embedded-Microprocessor-SAM9263_Datasheet.pdf
> (No NDA required)

(old memories) this 2D engine prove itself of being quite limited as the 
fill polygon and clipping functions are not working.

> Based on the above, would it be possible to utilise some
> of these features without any dedicated userspace (mesa) support?
> Any other driver that has something similar that can be used
> for inspiration?

This is really an interesting question indeed.

> Or is this in reality a simple GPU that requires a
> dedicated GPU driver?
> 
> 	Sam
> 


-- 
Nicolas Ferre
