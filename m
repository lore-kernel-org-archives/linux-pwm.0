From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Subject: Re: [PATCH 0/5] r8a7795/6 Salvator-X PWM enablement
Date: Fri, 21 Apr 2017 09:22:00 +0200
Message-ID: <CAO3366zg6guSCd0CiVFq7QUAYEGWHQ_sPTfQUyAUctxfqWvLTw@mail.gmail.com>
References: <1492608293-12435-1-git-send-email-ulrich.hecht+renesas@gmail.com> <CAMuHMdXX1Q8Fh07jkRvmVHmY3OBoSMbpFtByN2+KzSMfwAYq=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdXX1Q8Fh07jkRvmVHmY3OBoSMbpFtByN2+KzSMfwAYq=A@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Simon Horman <horms@verge.net.au>, Linux PWM List <linux-pwm@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>
List-Id: linux-pwm@vger.kernel.org

On Thu, Apr 20, 2017 at 4:23 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Hi Uli,
>
> On Wed, Apr 19, 2017 at 3:24 PM, Ulrich Hecht
> <ulrich.hecht+renesas@gmail.com> wrote:
>> This is a straight port from the BSP, enabling PWM1 and PWM2 on the
>> Salvator-X boards. For r8a7796 it also adds the required infrastructure
>> (clock and pins).
>>
>> Not fully tested because I cannot find my breakout adapter. Looks OK from
>> the software side, though.
>
> Did you manage to test it with the new "Easter bunny" adapter?

Yup, works. (Both the adapter and the PWMs.)

CU
Uli
