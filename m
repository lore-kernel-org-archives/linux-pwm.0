From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 05/12] docs: dt: fix references to
 ap806-system-controller.txt
Date: Mon, 30 Mar 2020 15:06:37 -0600
Message-ID: <20200330210637.GA9233@bogus>
References: <cover.1584450500.git.mchehab+huawei@kernel.org>
 <cf60ef88712e4f46f4e4bf40b2c646451d921827.1584450500.git.mchehab+huawei@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cf60ef88712e4f46f4e4bf40b2c646451d921827.1584450500.git.mchehab+huawei@kernel.org>
Sender: linux-gpio-owner@vger.kernel.org
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Thierry Reding <thierry.reding@gmail.com>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Zhang Rui <rui.zhang@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@verdurent.com>, Ben Peled <bpeled@marvell.com>, Miquel Raynal <miquel.raynal@bootlin.com>, Gregory CLEMENT <gregory.clement@bootlin.com>, linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On Tue, 17 Mar 2020 14:10:44 +0100, Mauro Carvalho Chehab wrote:
> ap806-system-controller.txt was renamed to ap80x-system-controller.txt.
> 
> Update its references accordingly.
> 
> Fixes: 2537831bbc19 ("dt-bindings: ap80x: replace AP806 with AP80x")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/devicetree/bindings/gpio/gpio-mvebu.txt        | 2 +-
>  Documentation/devicetree/bindings/thermal/armada-thermal.txt | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 

Applied, thanks.

Rob
