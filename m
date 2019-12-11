From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: pwm: fix nodename pattern
Date: Wed, 11 Dec 2019 13:52:48 -0600
Message-ID: <CAL_JsqJKWoX_kY2kSieOA-wXO5xKtDbhXPMCjg-d4FHHEvOmHg@mail.gmail.com>
References: <20191211150021.20125-1-benjamin.gaignard@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191211150021.20125-1-benjamin.gaignard@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Gaignard <benjamin.gaignard@st.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Mark Rutland <mark.rutland@arm.com>, Linux PWM List <linux-pwm@vger.kernel.org>, devicetree@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org

On Wed, Dec 11, 2019 at 9:00 AM Benjamin Gaignard
<benjamin.gaignard@st.com> wrote:
>
> Typical pwm nodes should be named pwm@xxx.
> The pattern shouldn't match nodes named pwm-xxx to avoid
> conflicts with pinmux or pwm-fan nodes.

It only matches pwm-$(a-hex-number), not any string, so that shouldn't
be a problem. This is needed for things like GPIO based devices (not
just PWMs) which don't have any address.

Pinmux nodes are going to need to adopt some sort of standard pattern
we can match on.

> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  Documentation/devicetree/bindings/pwm/pwm.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/pwm/pwm.yaml b/Documentation/devicetree/bindings/pwm/pwm.yaml
> index fa4f9de92090..29b86886c282 100644
> --- a/Documentation/devicetree/bindings/pwm/pwm.yaml
> +++ b/Documentation/devicetree/bindings/pwm/pwm.yaml
> @@ -11,7 +11,7 @@ maintainers:
>
>  properties:
>    $nodename:
> -    pattern: "^pwm(@.*|-[0-9a-f])*$"
> +    pattern: "^pwm(@.*[0-9a-f])*$"
>
>    "#pwm-cells":
>      description:
> --
> 2.15.0
>
