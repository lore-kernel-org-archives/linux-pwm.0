From: Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH 2/2] pwm: meson: add compatible for the gxbb ao pwms
Date: Wed, 7 Jun 2017 15:35:36 +0200
Message-ID: <767ce709-ca18-4ba6-77a1-baaeb52c9f1b@baylibre.com>
References: <20170607133013.4766-1-jbrunet@baylibre.com>
 <20170607133013.4766-3-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170607133013.4766-3-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>, Thierry Reding <thierry.reding@gmail.com>, Kevin Hilman <khilman@baylibre.com>
Cc: Carlo Caione <carlo@caione.org>, linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On 06/07/2017 03:30 PM, Jerome Brunet wrote:
> On the gxbb (and gxl) family, the PWMs of the AO domain require a
> specific compatible because the possible input clocks are different
> from the EE PWMs input clocks.
> 
> Since the number of possible input clocks is also different, the
> 'num_parents' field is added to all the meson pwm data.
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  drivers/pwm/pwm-meson.c | 32 +++++++++++++++++++++++++++++---
>  1 file changed, 29 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
> index 045ef9fa6fe3..a385fcc5cfad 100644
> --- a/drivers/pwm/pwm-meson.c
> +++ b/drivers/pwm/pwm-meson.c
> @@ -103,6 +103,7 @@ struct meson_pwm_channel {
>  
>  struct meson_pwm_data {
>  	const char * const *parent_names;
> +	int num_parents;
>  };
>  
>  struct meson_pwm {
> @@ -381,6 +382,7 @@ static const char * const pwm_meson8b_parent_names[] = {
>  
>  static const struct meson_pwm_data pwm_meson8b_data = {
>  	.parent_names = pwm_meson8b_parent_names,
> +	.num_parents = ARRAY_SIZE(pwm_meson8b_parent_names),
>  };
>  
>  static const char * const pwm_gxbb_parent_names[] = {
> @@ -389,11 +391,35 @@ static const char * const pwm_gxbb_parent_names[] = {
>  
>  static const struct meson_pwm_data pwm_gxbb_data = {
>  	.parent_names = pwm_gxbb_parent_names,
> +	.num_parents = ARRAY_SIZE(pwm_gxbb_parent_names),
> +};
> +
> +/*
> + * Only the 2 first inputs of the GXBB AO PWMs are valid
> + * The last 2 are grounded
> + */
> +static const char * const pwm_gxbb_ao_parent_names[] = {
> +	"clk81", "xtal"
> +};
> +
> +static const struct meson_pwm_data pwm_gxbb_ao_data = {
> +	.parent_names = pwm_gxbb_ao_parent_names,
> +	.num_parents = ARRAY_SIZE(pwm_gxbb_ao_parent_names),
>  };
>  
>  static const struct of_device_id meson_pwm_matches[] = {
> -	{ .compatible = "amlogic,meson8b-pwm", .data = &pwm_meson8b_data },
> -	{ .compatible = "amlogic,meson-gxbb-pwm", .data = &pwm_gxbb_data },
> +	{
> +		.compatible = "amlogic,meson8b-pwm",
> +		.data = &pwm_meson8b_data
> +	},
> +	{
> +		.compatible = "amlogic,meson-gxbb-pwm",
> +		.data = &pwm_gxbb_data
> +	},
> +	{
> +		.compatible = "amlogic,meson-gxbb-ao-pwm",
> +		.data = &pwm_gxbb_ao_data
> +	},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, meson_pwm_matches);
> @@ -417,7 +443,7 @@ static int meson_pwm_init_channels(struct meson_pwm *meson,
>  		init.ops = &clk_mux_ops;
>  		init.flags = CLK_IS_BASIC;
>  		init.parent_names = meson->data->parent_names;
> -		init.num_parents = 1 << MISC_CLK_SEL_WIDTH;
> +		init.num_parents = meson->data->num_parents;
>  
>  		channel->mux.reg = meson->base + REG_MISC_AB;
>  		channel->mux.shift = mux_reg_shifts[i];
> 

Acked-by: Neil Armstrong <narmstrong@baylibre.com>
