From: Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 14/14] regulator: pwm: Document pwm-dutycycle-unit and
 pwm-dutycycle-range
Date: Fri, 3 Jun 2016 14:04:24 -0700
Message-ID: <20160603210424.GL124478@google.com>
References: <1464942192-25967-1-git-send-email-boris.brezillon@free-electrons.com>
 <1464942192-25967-15-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1464942192-25967-15-git-send-email-boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Milo Kim <milo.kim-l0cyMroinI0@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org, Stephen Barber <smbarber-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Doug Anderson <dianders-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Maxime Coquelin <maxime.coquelin-qxv4g6HH51o@public.gmane.org>, Srinivas Kandagatla <srinivas.kandagatla-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Patrice Chotard <patrice.chotard-qxv4g6HH51o@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Ajit Pal Singh <ajitpal.singh-qxv4g6HH51o@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

On Fri, Jun 03, 2016 at 10:23:12AM +0200, Boris Brezillon wrote:
> Document the pwm-dutycycle-unit and pwm-dutycycle-range properties.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> ---
>  .../devicetree/bindings/regulator/pwm-regulator.txt          | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/regulator/pwm-regulator.txt b/Documentation/devicetree/bindings/regulator/pwm-regulator.txt
> index ed936f0..5303235 100644
> --- a/Documentation/devicetree/bindings/regulator/pwm-regulator.txt
> +++ b/Documentation/devicetree/bindings/regulator/pwm-regulator.txt
> @@ -34,6 +34,18 @@ Only required for Voltage Table Mode:
>  			    First cell is voltage in microvolts (uV)
>  			    Second cell is duty-cycle in percent (%)
>  
> +Optional properties for Continuous mode:
> +- pwm-dutycycle-unit:	Integer value encoding the dutycycle unit. If not
> +			defined, <100> is assumed, meaning that
> +			pwm-dutycycle-range contains values expressed in
> +			percent.
> +
> +- pwm-dutycycle-range:	Should contain 2 entries. The first entry is encoding
> +			the dutycycle for regulator-min-microvolt and the
> +			second one the dutycycle for regulator-max-microvolt.
> +			Dutycyle values are expressed in pwm-dutycycle-unit.
> +			If not defined, <0 100> is assumed.
> +
>  NB: To be clear, if voltage-table is provided, then the device will be used
>  in Voltage Table Mode.  If no voltage-table is provided, then the device will
>  be used in Continuous Voltage Mode.

Acked-by: Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
