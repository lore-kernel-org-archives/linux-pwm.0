From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 01/14] dt/bindings: Document pinctrl-ingenic
Date: Tue, 4 Apr 2017 09:48:51 -0500
Message-ID: <20170404144851.s53lj3hfdu5mjlx5@rob-hp-laptop>
References: <20170125185207.23902-2-paul@crapouillou.net>
 <20170402204244.14216-1-paul@crapouillou.net>
 <20170402204244.14216-2-paul@crapouillou.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170402204244.14216-2-paul@crapouillou.net>
Sender: linux-mmc-owner@vger.kernel.org
To: Paul Cercueil <paul@crapouillou.net>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Ralf Baechle <ralf@linux-mips.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, Thierry Reding <thierry.reding@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Maarten ter Huurne <maarten@treewalker.org>, Lars-Peter Clausen <lars@metafoo.de>, Paul Burton <paul.burton@imgtec.com>, james.hogan@imgtec.com, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On Sun, Apr 02, 2017 at 10:42:31PM +0200, Paul Cercueil wrote:
> This commit adds documentation for the devicetree bindings of the
> pinctrl-ingenic driver, which handles pin configuration and pin
> muxing of the Ingenic SoCs currently supported by the Linux kernel.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  .../bindings/pinctrl/ingenic,pinctrl.txt           | 41 ++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/ingenic,pinctrl.txt

Acked-by: Rob Herring <robh@kernel.org>
