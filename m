From: Doug Anderson <dianders@google.com>
Subject: Re: [PATCH v3 00/12] pwm: add support for atomic update
Date: Mon, 25 Jan 2016 08:28:31 -0800
Message-ID: <CAD=FV=WL3jYEgVe-m6QcAyQwfJgdX4J5OtKisKwyoKOrTSpEQA@mail.gmail.com>
References: <1442828009-6241-1-git-send-email-boris.brezillon@free-electrons.com>
	<2341981.a79ioYM9Es@diego>
	<20151110173416.GB21727@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-yk0-f173.google.com ([209.85.160.173]:35305 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754095AbcAYQ2c convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 25 Jan 2016 11:28:32 -0500
Received: by mail-yk0-f173.google.com with SMTP id u68so37878410ykd.2
        for <linux-pwm@vger.kernel.org>; Mon, 25 Jan 2016 08:28:32 -0800 (PST)
In-Reply-To: <20151110173416.GB21727@ulmo>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, linux-pwm <linux-pwm@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, linux-fbdev@vger.kernel.org, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <j.anaszewski@samsung.com>, linux-leds@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-sunxi@googlegroups.com, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>"linux-kernel@vger.kernel.org" <li>

Thierry and Boris,

On Tue, Nov 10, 2015 at 9:34 AM, Thierry Reding
<thierry.reding@gmail.com> wrote:
> On Mon, Oct 19, 2015 at 12:12:12PM +0200, Heiko St=C3=BCbner wrote:
>> Hi Thierry,
>>
>> Am Montag, 21. September 2015, 11:33:17 schrieb Boris Brezillon:
>> > Hello,
>> >
>> > This series adds support for atomic PWM update, or IOW, the capabi=
lity
>> > to update all the parameters of a PWM device (enabled/disabled, pe=
riod,
>> > duty and polarity) in one go.
>>
>> is anything more blocking this series? It's now sitting on the lists=
 for
>> nearly a month and everybody seems happy with it, so it would be rea=
lly nice
>> to have in mainline :-) .
>>
>> Especially as this also makes it possible for Rockchip Chromebooks t=
o actually
>> control the logic-regulator that is implemented as pwm-regulator the=
re.
>
> Last time I tried to put this into linux-next I got immediately
> bombarded by a number of build failures, so I backed things out. The
> current plan is to give this another try after v4.4-rc1.

We're now into the 4.5 timeframe.  Does anyone have a concrete set of
things that need to happen before this patch series makes it into
mainline?

=46rom searching I see that the latest version of this series is v4 and
there are a smattering of comments on the 24-patch series.  Presumably
a v5 needs to be posted to address those things.

=2E..but it looks like the big sticking point is that Boris is waiting
for a response to his questions in
<https://patchwork.kernel.org/patch/7622881/>.  Thierry: can you give
Boris some direction for what else he needs to do?  We need to come up
with _some_ solution since this series gets us much better support for
PWM regulators.  Without this series or some other solution, PWM
regulators aren't usable in mainline on any system that uses them for
system-critical rails.  Nearly all Rockchip reference boards and
shipping devices uses a PWM regulator for the system-critidal "logic"
rail.  That means any patches which need to change this rail in Linux
are blocked.

If there's already been off-list discussion and Boris already knows
what the next steps are then my apologies and I'll wait patiently for
the next series.  ;)

Thanks!

-Doug
