From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Subject: Re: [PATCH 5/5] arm64: dts: r8a7795-salvator-x: Enable PWM
Date: Mon, 24 Apr 2017 12:02:17 +0200
Message-ID: <CAO3366yMRXnuL9mMPVA2-FwLmz0gaPLtk413K06Q42nQO48L7Q@mail.gmail.com>
References: <1492608293-12435-1-git-send-email-ulrich.hecht+renesas@gmail.com>
 <2637169.nvyUM18Pqy@avalon> <CAO3366xaWH7YtktGpJ07ypzxuudyJc63PxxAeVeOi98Rann1Lg@mail.gmail.com>
 <2906686.sXpvJSxI8y@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <2906686.sXpvJSxI8y@avalon>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Simon Horman <horms@verge.net.au>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux PWM List <linux-pwm@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Takeshi Kihara <takeshi.kihara.df@renesas.com>
List-Id: linux-pwm@vger.kernel.org

On Mon, Apr 24, 2017 at 10:35 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Hi Ulrich,
>
> On Monday 24 Apr 2017 10:22:31 Ulrich Hecht wrote:
>> On Mon, Apr 24, 2017 at 9:59 AM, Laurent Pinchart wrote:
>> > How about using pwm1 for backlight as done in "[PATCH v2 09/13] arm64:
>> > dts: r8a7795: salvator-x: Add panel backlight support" ?
>>
>> Makes sense. Simon, should that go in a separate patch, or should I
>> add it to this one?
>
> How about applying "[PATCH v2 09/13] arm64: dts: r8a7795: salvator-x: Add
> panel backlight support" and rebasing this patch to only handle pwm2 ?

I'll do that then.

CU
Uli
