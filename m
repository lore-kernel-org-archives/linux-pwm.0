From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 1/7] dt-bindings: pwm: allwinner: Add H6 PWM
 description
Date: Tue, 12 Nov 2019 13:31:33 -0600
Message-ID: <20191112193133.GA27088@bogus>
References: <20191108084517.21617-1-peron.clem@gmail.com>
 <20191108084517.21617-2-peron.clem@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191108084517.21617-2-peron.clem@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Thierry Reding <thierry.reding@gmail.com>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Chen-Yu Tsai <wens@csie.org>, Philipp Zabel <pza@pengutronix.de>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com, Jernej Skrabec <jernej.skrabec@siol.net>, =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
List-Id: linux-pwm@vger.kernel.org

On Fri,  8 Nov 2019 09:45:11 +0100, =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= wrote:
> From: Jernej Skrabec <jernej.skrabec@siol.net>
> 
> H6 PWM block is basically the same as A20 PWM, except that it also has
> bus clock and reset line which needs to be handled accordingly.
> 
> Expand Allwinner PWM binding with H6 PWM specifics.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> Signed-off-by: Clément Péron <peron.clem@gmail.com>
> ---
>  .../bindings/pwm/allwinner,sun4i-a10-pwm.yaml | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
