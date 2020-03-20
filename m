From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v11 09/12] pwm: sun4i: Use 64-bit division function
Date: Fri, 20 Mar 2020 18:02:49 +0100
Message-ID: <CAK8P3a2fdx55uNPqYxbVhUJZS2hBsCcr4u0i9dmoDkrdjVOMeA@mail.gmail.com>
References: <cover.1584667964.git.gurus@codeaurora.org> <a1942f735fa4d3eb71546a3f07d9b5e78fd7919a.1584667964.git.gurus@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a1942f735fa4d3eb71546a3f07d9b5e78fd7919a.1584667964.git.gurus@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Guru Das Srinagesh <gurus@codeaurora.org>
Cc: Linux PWM List <linux-pwm@vger.kernel.org>, Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Subbaraman Narayanamurthy <subbaram@codeaurora.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Philipp Zabel <p.zabel@pengutronix.de>
List-Id: linux-pwm@vger.kernel.org

On Fri, Mar 20, 2020 at 2:42 AM Guru Das Srinagesh <gurus@codeaurora.org> wrote:
>         sun4i_pwm->next_period[pwm->hwpwm] = jiffies +
> -               usecs_to_jiffies(cstate.period / 1000 + 1);
> +               usecs_to_jiffies(div_u64(cstate.period, 1000) + 1);
>         sun4i_pwm->needs_delay[pwm->hwpwm] = true;
>

This one looks like it should use nsecs_to_jiffies(cstate.period) to avoid
having two 64-bit divisions.

       Arnd
