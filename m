From: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Subject: Re: [PATCH 1/3] dt-bindings: added new pwm-sifive driver
 documentation
Date: Sun, 29 Apr 2018 23:01:20 +0200
Message-ID: <60772240-3c75-7814-9237-d60916a8ceca@suse.de>
References: <1524869998-2805-1-git-send-email-wesley@sifive.com>
 <1524869998-2805-2-git-send-email-wesley@sifive.com>
 <20180429055417.GA10221@mithrandir>
 <CAMgXwTgN26aKaSuVdSj2TDUgbR7bAmy4TdtOuKj_QC0kNNbphg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMgXwTgN26aKaSuVdSj2TDUgbR7bAmy4TdtOuKj_QC0kNNbphg@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wesley Terpstra <wesley@sifive.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>, David Lechner <david@lechnology.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, SZ Lin <sz.lin@moxa.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Am 29.04.2018 um 22:51 schrieb Wesley Terpstra:
> On Sat, Apr 28, 2018 at 10:54 PM, Thierry Reding
> <thierry.reding@gmail.com> wrote:
>> On Fri, Apr 27, 2018 at 03:59:56PM -0700, Wesley W. Terpstra wrote:
>>> +Required properties:
>>> +- compatible: should be "sifive,pwm0"
>>
>> Why not simply "sifive,pwm"? If this is supposed to be some sort of
>> version number, then it is more customary to use the name of the first
>> SoC that integrates the IP. There are some exceptions, like for example
>> when the IP is third-party and is integrated in a number of different
>> SoCs. In such cases the IP is often properly versioned. But that doesn't
>> seem to be the case here.
> 
> It is indeed a version number. The first SoC which integrated this IP
> cannot run linux. We've put a version number like this into all of our
> IP blocks. Isn't an increasing number, which clearly indicates
> increased functionality, better than a reference to a sequence of SoCs
> whose relationships are not all that clear?

"pwm0" sounds like a zero-indexed instance of some pwm block. If 0 is
the version here, I'd suggest to make it "pwm-0" for example - you might
want to take a look at the Xilinx bindings, which use a strict x.yy suffix.

Most SoCs don't have clearly versioned IP though, that's why for
community-contributed bindings the first SoC we encounter the IP in
usually gets the name.

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
