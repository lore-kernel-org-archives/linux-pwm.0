From: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Subject: Re: [PATCH 1/3] dt-bindings: added new pwm-sifive driver
 documentation
Date: Mon, 30 Apr 2018 12:45:20 +0200
Message-ID: <61f24d16-5095-76e4-845e-2434029fe1f0@suse.de>
References: <1524869998-2805-1-git-send-email-wesley@sifive.com>
 <1524869998-2805-2-git-send-email-wesley@sifive.com>
 <20180429055417.GA10221@mithrandir>
 <CAMgXwTgN26aKaSuVdSj2TDUgbR7bAmy4TdtOuKj_QC0kNNbphg@mail.gmail.com>
 <60772240-3c75-7814-9237-d60916a8ceca@suse.de>
 <CAMgXwThYN1E=awkd8yF2aNN+QOLwHkx=UyWqGrOnMxv5jyVj5g@mail.gmail.com>
 <20180430081946.GH2484@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180430081946.GH2484@ulmo>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Wesley Terpstra <wesley@sifive.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>, David Lechner <david@lechnology.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, SZ Lin <sz.lin@moxa.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Am 30.04.2018 um 10:19 schrieb Thierry Reding:
> On Sun, Apr 29, 2018 at 02:08:07PM -0700, Wesley Terpstra wrote:
>> On Sun, Apr 29, 2018 at 2:01 PM, Andreas Färber <afaerber@suse.de> wrote:
>>> "pwm0" sounds like a zero-indexed instance of some pwm block. If 0 is
>>> the version here, I'd suggest to make it "pwm-0" for example - you might
>>> want to take a look at the Xilinx bindings, which use a strict x.yy suffix.
>>
>> That's fine. I'll change it to pwm-0.00 in the next patch series.
> 
> This should match the version that you use. If you're internal
> versioning uses single digits, or a single version number, then I think
> there's no need to use 0.00, because that would just be confusing.
> However I think it'd be good to make sure it is discernible as a version
> number. Perhaps something like sifive,pwm-v0. That seems to be a fairly
> common scheme.

Yes. My point was not to adopt another vendor's versioning scheme but to
adopt _some_ consistent scheme and document it, e.g., in a sifive.txt
similar to xilinx.txt:

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Documentation/devicetree/bindings/xilinx.txt

It should be made clear what in the compatible string the version is
(thus my proposal of using a dash as separator), and there you may want
to document how to map between IP/documentation and compatibles for any
new bindings.

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
