From: Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH] pwm: meson: fix mux clock names
Date: Wed, 1 Aug 2018 12:59:31 +0200
Message-ID: <75d87aa4-68b5-8182-f67f-5704e7b1bef3@baylibre.com>
References: <20180801105720.23999-1-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180801105720.23999-1-jbrunet@baylibre.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>, Thierry Reding <thierry.reding@gmail.com>, Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>
Cc: linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On 01/08/2018 12:57, Jerome Brunet wrote:
> Current clock name looks like this:
> /soc/bus@ffd00000/pwm@1b000#mux0
> 
> This is bad because CCF uses the clock to create a directory in clk debugfs.
> With such name, the directory creation (silently) fails and the debugfs
> entry end up being created at the debugfs root.
> 
> With this change, the clock name will now be:
> ffd1b000.pwm#mux0
> 
> This matches the clock naming scheme used in the ethernet and mmc driver.
> It also fixes the problem with debugfs.
> 
> Fixes: 36af66a79056 ("pwm: Convert to using %pOF instead of full_name")
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  drivers/pwm/pwm-meson.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
> index 822860b4801a..c1ed641b3e26 100644
> --- a/drivers/pwm/pwm-meson.c
> +++ b/drivers/pwm/pwm-meson.c
> @@ -458,7 +458,6 @@ static int meson_pwm_init_channels(struct meson_pwm *meson,
>  				   struct meson_pwm_channel *channels)
>  {
>  	struct device *dev = meson->chip.dev;
> -	struct device_node *np = dev->of_node;
>  	struct clk_init_data init;
>  	unsigned int i;
>  	char name[255];
> @@ -467,7 +466,7 @@ static int meson_pwm_init_channels(struct meson_pwm *meson,
>  	for (i = 0; i < meson->chip.npwm; i++) {
>  		struct meson_pwm_channel *channel = &channels[i];
>  
> -		snprintf(name, sizeof(name), "%pOF#mux%u", np, i);
> +		snprintf(name, sizeof(name), "%s#mux%u", dev_name(dev), i);
>  
>  		init.name = name;
>  		init.ops = &clk_mux_ops;
> 

Acked-by: Neil Armstrong <narmstrong@baylibre.com>
