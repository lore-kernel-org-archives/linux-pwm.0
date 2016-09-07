From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 3/4] pinctrl: sunxi: Remove unsupported PWM channel
 pinmux in H3
Date: Thu, 8 Sep 2016 01:09:29 +0200
Message-ID: <CACRpkda8uMuOi41O5Cq3o-PXynoZfkxAD7P2fHS-uCUQt_B_kA@mail.gmail.com>
References: <20160831082520.25962-1-woogyom.kim@gmail.com>
 <20160831082520.25962-4-woogyom.kim@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160831082520.25962-4-woogyom.kim@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Milo Kim <woogyom.kim@gmail.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Krzysztof Adamski <k@japko.eu>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Icenowy Zheng <icenowy@aosc.xyz>, Maxime Ripard <maxime.ripard@free-electrons.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Jens Kuske <jenskuske@gmail.com>
List-Id: linux-pwm@vger.kernel.org

On Wed, Aug 31, 2016 at 10:25 AM, Milo Kim <woogyom.kim@gmail.com> wrote:

> H3 has single PWM channel. The second PWM channel is not supported,
> so the pinctrl function should be removed.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Icenowy Zheng <icenowy@aosc.xyz>
> Cc: Jens Kuske <jenskuske@gmail.com>
> Cc: Krzysztof Adamski <k@japko.eu>
> Cc: linux-gpio@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Milo Kim <woogyom.kim@gmail.com>

Patch applied with Chen-Yu's ACK.

Yours,
Linus Walleij
