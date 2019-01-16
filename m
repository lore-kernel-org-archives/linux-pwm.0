From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/1] doc: gpio-mvebu: fix broken reference to
 cp110-system-controller0.txt file
Date: Wed, 16 Jan 2019 13:02:32 -0600
Message-ID: <CAL_JsqJFcUnDPmsZpvrxn3EsR5+B4jcjHonWsEsDrNxc98rZTA@mail.gmail.com>
References: <8fd140950dd0bb859f9a48d8b25fb919cbb3cc6b.1547059503.git.ottosabart@seberm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8fd140950dd0bb859f9a48d8b25fb919cbb3cc6b.1547059503.git.ottosabart@seberm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Otto Sabart <ottosabart@seberm.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux PWM List <linux-pwm@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, devicetree@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>, Thierry Reding <thierry.reding@gmail.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-pwm@vger.kernel.org

On Wed, Jan 9, 2019 at 1:07 PM Otto Sabart <ottosabart@seberm.com> wrote:
>
> The cp110-system-controller0.txt file was renamed to
> cp110-system-controller.txt.
>
> Fixes: 4aa5496980e4 ("dt-bindings: cp110: rename cp110 syscon file")
> Signed-off-by: Otto Sabart <ottosabart@seberm.com>
> ---
>  Documentation/devicetree/bindings/gpio/gpio-mvebu.txt | 2 --
>  1 file changed, 2 deletions(-)

Applied, thanks.

Rob
