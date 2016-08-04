From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH v2 0/4] pwm: Add Amlogic Meson SoC PWM Controller
Date: Wed, 3 Aug 2016 17:25:29 -0700
Message-ID: <CAOi56cVGRpSeAVwaATkx8Q2wz9hxocq6095opJQZucfDML2wSg@mail.gmail.com>
References: <1468142645-4360-1-git-send-email-narmstrong@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-oi0-f51.google.com ([209.85.218.51]:36006 "EHLO
	mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751867AbcHDA0s (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 3 Aug 2016 20:26:48 -0400
Received: by mail-oi0-f51.google.com with SMTP id f189so28901738oig.3
        for <linux-pwm@vger.kernel.org>; Wed, 03 Aug 2016 17:25:30 -0700 (PDT)
In-Reply-To: <1468142645-4360-1-git-send-email-narmstrong@baylibre.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Carlo Caione <carlo@caione.org>, linux-pwm@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-amlogic@lists.infradead.org, lkml <linux-kernel@vger.kernel.org>

Hi Thierry,

On Sun, Jul 10, 2016 at 2:27 AM, Neil Armstrong <narmstrong@baylibre.com> wrote:
> Add support for the PWM controller found in Amlogic Meson SoCs.
> This controller provides a dual PWM output with 4 selectable clock source
> and a two level divider to achieve a better PWM range.
>
> Currently Meson8b and GXBB SoCs are supported.
>
> Changes since v1 at http://lkml.kernel.org/r/1466173784-15625-1-git-send-email-narmstrong@baylibre.com :
> - fix meson8b dtsi

Gentle reminder ping on this series.

Thanks,

Kevin
