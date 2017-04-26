From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Subject: Re: [PATCH 5/5] arm64: dts: r8a7795-salvator-x: Enable PWM
Date: Wed, 26 Apr 2017 09:57:12 +0200
Message-ID: <CAO3366yZTrt0b4uo3JS7KNi1Ro3n5P2Zb0xFm_op3Z8ccGNqvQ@mail.gmail.com>
References: <1492608293-12435-1-git-send-email-ulrich.hecht+renesas@gmail.com>
 <2637169.nvyUM18Pqy@avalon> <CAO3366xaWH7YtktGpJ07ypzxuudyJc63PxxAeVeOi98Rann1Lg@mail.gmail.com>
 <2906686.sXpvJSxI8y@avalon> <CAO3366yMRXnuL9mMPVA2-FwLmz0gaPLtk413K06Q42nQO48L7Q@mail.gmail.com>
 <20170426075003.GH25517@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-oi0-f41.google.com ([209.85.218.41]:34951 "EHLO
        mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1956570AbdDZH5N (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 26 Apr 2017 03:57:13 -0400
In-Reply-To: <20170426075003.GH25517@verge.net.au>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux PWM List <linux-pwm@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Takeshi Kihara <takeshi.kihara.df@renesas.com>

On Wed, Apr 26, 2017 at 9:50 AM, Simon Horman <horms@verge.net.au> wrote:
> On Mon, Apr 24, 2017 at 12:02:17PM +0200, Ulrich Hecht wrote:
>> On Mon, Apr 24, 2017 at 10:35 AM, Laurent Pinchart
>> <laurent.pinchart@ideasonboard.com> wrote:
>> > Hi Ulrich,
>> >
>> > On Monday 24 Apr 2017 10:22:31 Ulrich Hecht wrote:
>> >> On Mon, Apr 24, 2017 at 9:59 AM, Laurent Pinchart wrote:
>> >> > How about using pwm1 for backlight as done in "[PATCH v2 09/13] arm64:
>> >> > dts: r8a7795: salvator-x: Add panel backlight support" ?
>> >>
>> >> Makes sense. Simon, should that go in a separate patch, or should I
>> >> add it to this one?
>> >
>> > How about applying "[PATCH v2 09/13] arm64: dts: r8a7795: salvator-x: Add
>> > panel backlight support" and rebasing this patch to only handle pwm2 ?
>>
>> I'll do that then.
>
> Do you need any more input from me at this time?

No, I'm fine, thanks.

CU
Uli
