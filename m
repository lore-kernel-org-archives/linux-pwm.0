From: "'Doug Anderson' via linux-sunxi" <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Subject: Re: [PATCH v3 00/12] pwm: add support for atomic update
Date: Mon, 7 Mar 2016 08:34:19 -0800
Message-ID: <CAD=FV=W3KPf8tyMviVNB9=HjefMdP+FBbN01Zhh7RKH+gkj2WQ@mail.gmail.com>
References: <20151110173416.GB21727@ulmo>
	<CAD=FV=WL3jYEgVe-m6QcAyQwfJgdX4J5OtKisKwyoKOrTSpEQA@mail.gmail.com>
	<20160125170855.GA10182@ulmo>
	<CAD=FV=Xvxeqo3imUmjukC5iYk3EZkrJ04G7C1B-w4xyr-r6-2Q@mail.gmail.com>
	<20160203145337.GD9650@ulmo>
	<CAD=FV=U_x1cxx6RrHuVgVV8GbOwm9DXXJcyiArbbQySUOaxrvQ@mail.gmail.com>
	<20160222175929.GA23899@ulmo>
	<CAD=FV=UCErW3EjYRtwt49_ztNR7cyY4U0o4R_dxdomer-Ac2Dg@mail.gmail.com>
	<20160223143859.GA27656@ulmo>
	<CAD=FV=UvxG3MYD4MKQJqN7W68uMjd-s+FH-e8tkrLCpS0RLmZQ@mail.gmail.com>
	<20160223181448.GA14754@ulmo.nvidia.com>
	<CAD=FV=VM3cOQ0HqwLANBw9MVBCyFTrSyPe_dGzgPucuMUEWRKA@mail.gmail.com>
	<CAD=FV=VckTVD8b1g+f0G2kMeoTjvY0pAGhoDnWQN_dAmqSxBxg@mail.gmail.com>
Reply-To: dianders-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBDR6JO4Q7MHRBDG3623AKGQEBED5TIY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <CAD=FV=VckTVD8b1g+f0G2kMeoTjvY0pAGhoDnWQN_dAmqSxBxg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-pwm <linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jingoo Han <jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Jacek Anaszewski <j.anaszewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>, Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel@l>
List-Id: linux-pwm@vger.kernel.org

Thierry,

On Thu, Feb 25, 2016 at 3:14 PM, Doug Anderson <dianders-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org> wrote:
> So just to summarize:
>
> * Add pwm_get_state(), pwm_apply_state(), pwm_get_args().
> pwm_get_state() initially returns 0 for duty cycle if driver doesn't
> support readout.
>
> * Re-implement pwm_get_period() (and maybe other similar functions)
> atop pwm_get_state() as you describe earlier in the thread.
>
> * Document pwm_get_period() (and maybe other similar functions) as deprecated.
>
> * Fix drivers for all current 2 users of PWM regulator to support
> hardware readout.
>
> * Update PWM regulator as you described earlier in the thread (Feb 23).
>
> * If PWM regulator is ever used on a new board whose PWM doesn't
> support hardware readout, the voltage will change at probe time.
>
>
> Did I get all that right?  Thanks!

Can you provide a "yes, you got that right" or a "no, you didn't
understand"?  That will unblock Boris, I think.

-Doug
