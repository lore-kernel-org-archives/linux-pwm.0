From: Wesley Terpstra <wesley@sifive.com>
Subject: Re: [PATCH 1/3] dt-bindings: added new pwm-sifive driver documentation
Date: Sun, 29 Apr 2018 14:08:07 -0700
Message-ID: <CAMgXwThYN1E=awkd8yF2aNN+QOLwHkx=UyWqGrOnMxv5jyVj5g@mail.gmail.com>
References: <1524869998-2805-1-git-send-email-wesley@sifive.com>
 <1524869998-2805-2-git-send-email-wesley@sifive.com> <20180429055417.GA10221@mithrandir>
 <CAMgXwTgN26aKaSuVdSj2TDUgbR7bAmy4TdtOuKj_QC0kNNbphg@mail.gmail.com> <60772240-3c75-7814-9237-d60916a8ceca@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <60772240-3c75-7814-9237-d60916a8ceca@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
Cc: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>, David Lechner <david@lechnology.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, SZ Lin <sz.lin@moxa.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On Sun, Apr 29, 2018 at 2:01 PM, Andreas F=C3=A4rber <afaerber@suse.de> wro=
te:
> "pwm0" sounds like a zero-indexed instance of some pwm block. If 0 is
> the version here, I'd suggest to make it "pwm-0" for example - you might
> want to take a look at the Xilinx bindings, which use a strict x.yy suffi=
x.

That's fine. I'll change it to pwm-0.00 in the next patch series.

> Most SoCs don't have clearly versioned IP though, that's why for
> community-contributed bindings the first SoC we encounter the IP in
> usually gets the name.

In this particular case, we do have versioned IP, and we will be
contributing drivers for those which wind up in linux-capable chips.
