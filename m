From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH AUTOSEL 5.4 053/205] pwm: sun4i: Fix incorrect
 calculation of duty_cycle/period
Date: Thu, 16 Jan 2020 17:56:14 +0100
Message-ID: <20200116165614.a3u5x7g4qxxrm6s4@pengutronix.de>
References: <20200116164300.6705-1-sashal@kernel.org>
 <20200116164300.6705-53-sashal@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20200116164300.6705-53-sashal@kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: Sasha Levin <sashal@kernel.org>
Cc: Ondrej Jirman <megous@megous.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

On Thu, Jan 16, 2020 at 11:40:28AM -0500, Sasha Levin wrote:
> From: Ondrej Jirman <megous@megous.com>
> =

> [ Upstream commit 50cc7e3e4f26e3bf5ed74a8d061195c4d2161b8b ]
> =

> Since 5.4-rc1, pwm_apply_state calls ->get_state after ->apply
> if available, and this revealed an issue with integer precision
> when calculating duty_cycle and period for the currently set
> state in ->get_state callback.
> =

> This issue manifested in broken backlight on several Allwinner
> based devices.
> =

> Previously this worked, because ->apply updated the passed state
> directly.
> =

> Fixes: deb9c462f4e53 ("pwm: sun4i: Don't update the state for the caller =
of pwm_apply_state")
> Signed-off-by: Ondrej Jirman <megous@megous.com>
> Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Note that while the patch is still correct, the problem isn't that bad
any more since commit 01ccf903edd65f6421612321648fa5a7f4b7cb10 was
reverted.

So .get_state is only called once during boot where the breakage doesn't
hurt that much.

I let you decide if you still want to apply this patch.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
