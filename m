From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] pwm: avoid disabling clk twice
Date: Mon, 29 Jul 2019 08:25:48 +0200
Message-ID: <20190729062548.4pio5sfuxfwwxecr@pengutronix.de>
References: <20190727070916.2960-1-xywang.sjtu@sjtu.edu.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190727070916.2960-1-xywang.sjtu@sjtu.edu.cn>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+glpr-linux-riscv=m.gmane.org@lists.infradead.org
To: Wang Xiayang <xywang.sjtu@sjtu.edu.cn>, Yash Shah <yash.shah@sifive.com>
Cc: linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org, thierry.reding@gmail.com, palmer@sifive.com, paul.walmsley@sifive.com
List-Id: linux-pwm@vger.kernel.org

Hello,

On Sat, Jul 27, 2019 at 03:09:16PM +0800, Wang Xiayang wrote:
> Similar to commit 63fd4b94b948 ("serial: imx: fix error handling
> in console_setup"), as ddata->clk has been explicitly disabled two
> lines above, it should avoid being disabled for the second time.
> clk_unprepare() suits here better.
> =

> Signed-off-by: Wang Xiayang <xywang.sjtu@sjtu.edu.cn>
> ---
>  drivers/pwm/pwm-sifive.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> =

> diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
> index a7c107f19e66..00f6fab5bd3b 100644
> --- a/drivers/pwm/pwm-sifive.c
> +++ b/drivers/pwm/pwm-sifive.c
> @@ -312,7 +312,7 @@ static int pwm_sifive_remove(struct platform_device *=
dev)
>  	if (is_enabled)
>  		clk_disable(ddata->clk);
>  =

> -	clk_disable_unprepare(ddata->clk);
> +	clk_unprepare(ddata->clk);
>  	ret =3D pwmchip_remove(&ddata->chip);
>  	clk_notifier_unregister(ddata->clk, &ddata->notifier);

I think this patch is wrong.

After a successfull call to .probe the clock is left prepared and
enabled. This is undone in the unconditional call to
clk_disable_unprepare that you removed.

There is however still a problem: If Linux is started with the pwm
enabled (such that .get_state returns state->enabled =3D true) then
disabling the pwm has one clk_disable too much.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
