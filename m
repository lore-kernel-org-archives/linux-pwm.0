From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Subject: Re: [PATCH 3/6] arm64: dts: r8a7795: Add PWM device nodes
Date: Tue, 29 Mar 2016 17:49:57 +0200
Message-ID: <CAO3366z7n0M8Y_Dxs5zsbzDXOkKerojM0nLsaL0q52Ef+NipKA@mail.gmail.com>
References: <1457542562-7880-1-git-send-email-ulrich.hecht+renesas@gmail.com>
	<1457542562-7880-4-git-send-email-ulrich.hecht+renesas@gmail.com>
	<CAMuHMdUzD91D+DJUycy09gaMJYm_XkDTx1ux+6g9xznu-W89Pw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:35898 "EHLO
	mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752017AbcC2Pt6 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 29 Mar 2016 11:49:58 -0400
In-Reply-To: <CAMuHMdUzD91D+DJUycy09gaMJYm_XkDTx1ux+6g9xznu-W89Pw@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-renesas-soc@vger.kernel.org, Linux PWM List <linux-pwm@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Ryo Kodama <ryo.kodama.vz@renesas.com>, Harunobu Kurokawa <harunobu.kurokawa.dn@renesas.com>

On Thu, Mar 24, 2016 at 2:52 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Hi Ulrich,
>
> On Wed, Mar 9, 2016 at 5:55 PM, Ulrich Hecht
> <ulrich.hecht+renesas@gmail.com> wrote:
[...]
>> diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
>> index 5367a7b..531e3b6 100644
>> --- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
>> +++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
>> @@ -618,6 +618,60 @@
>>                         status = "disabled";
>>                 };
>>
>> +               pwm1: pwm@e6e31000 {
>
> Any specific reason pwm0 is not included?

No good one. I'll add it.

CU
Uli
