From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH 2/3] pwm: meson: Add clock source configuration for Meson
 G12A
Date: Sat, 13 Apr 2019 13:33:14 +0200
Message-ID: <CAFBinCA3iFSW4K8FJN913CcsxM4YFc2Of9Ldpn7230Ss427mMA@mail.gmail.com>
References: <20190412092337.6941-1-narmstrong@baylibre.com>
 <20190412092337.6941-3-narmstrong@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190412092337.6941-3-narmstrong@baylibre.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: linux-pwm@vger.kernel.org, baylibre-upstreaming@groups.io, linux-kernel@vger.kernel.org, thierry.reding@gmail.com, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

Hi Neil,

On Fri, Apr 12, 2019 at 11:24 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> For PWM controller in the Meson G12A SoC, the EE domain and AO domain
> have different clock sources. This patch tries to describe them in the
> DT compatible data.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/pwm/pwm-meson.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
> index 2b03938039b6..46287cc8a0eb 100644
> --- a/drivers/pwm/pwm-meson.c
> +++ b/drivers/pwm/pwm-meson.c
> @@ -434,6 +434,15 @@ static const struct meson_pwm_data pwm_axg_ao_data = {
>         .num_parents = ARRAY_SIZE(pwm_axg_ao_parent_names),
>  };
>
> +static const char * const pwm_g12a_ee_parent_names[] = {
> +       "xtal", "hdmi_pll", "fclk_div4", "fclk_div3"
> +};
> +
> +static const struct meson_pwm_data pwm_g12a_ee_data = {
> +       .parent_names = pwm_g12a_ee_parent_names,
> +       .num_parents = ARRAY_SIZE(pwm_g12a_ee_parent_names),
> +};
> +
>  static const struct of_device_id meson_pwm_matches[] = {
>         {
>                 .compatible = "amlogic,meson8b-pwm",
> @@ -455,6 +464,14 @@ static const struct of_device_id meson_pwm_matches[] = {
>                 .compatible = "amlogic,meson-axg-ao-pwm",
>                 .data = &pwm_axg_ao_data
>         },
> +       {
> +               .compatible = "amlogic,meson-g12a-ee-pwm",
> +               .data = &pwm_g12a_ee_data
> +       },
the PWM part is fine for me

> +       {
> +               .compatible = "amlogic,meson-g12a-ao-pwm",
> +               .data = &pwm_axg_ao_data
> +       },
>         {},
but I'm not sure about "amlogic,meson-g12a-ao-pwm":
the public S922X datasheet from Hardkernel [0] section 6.6.1.2 "AO
Clock Tree" (page 107) mentions two different clock sources for the AO
PWMs:
- AO PWM A and B has parents xtal, aoclk81, fclk_div4 and fclk_div5
(pwm_axg_ao_data has the first two parents swapped)
- AO PWM C and D only have xtal and aoclk81 as parents

regarding the clock parents:
I'm not sure whether pwm_axg_ao_data is wrong, G12A is different from
G12B or the G12B datasheet is "correct". can you please list what you
have tested so far and confirm that the parents you are using are
"correct"

regarding the compatible string "amlogic,meson-g12a-ao-pwm":
if there are two different AO PWM modules, should we name it
differently, for example by splitting this compatible string into:
- "amlogic,meson-g12a-ao-pwm-ab" (with parents: xtal, aoclk81,
fclk_div4 and fclk_div5)
- "amlogic,meson-g12a-ao-pwm-cd" (with parents: xtal and aoclk81)


Regards
Martin


[0] https://dn.odroid.com/S922X/ODROID-N2/Datasheet/S922X_Public_Datasheet_V0.2.pdf
