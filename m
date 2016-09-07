From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH v3 0/4] pwm: Add Amlogic Meson SoC PWM Controller
Date: Wed, 07 Sep 2016 13:19:21 -0700
Message-ID: <7hshtbsbsm.fsf@baylibre.com>
References: <1471880193-21879-1-git-send-email-narmstrong@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:35786 "EHLO
        mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752040AbcIGUTX (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 7 Sep 2016 16:19:23 -0400
Received: by mail-pa0-f46.google.com with SMTP id b2so9482638pat.2
        for <linux-pwm@vger.kernel.org>; Wed, 07 Sep 2016 13:19:22 -0700 (PDT)
In-Reply-To: <1471880193-21879-1-git-send-email-narmstrong@baylibre.com> (Neil
        Armstrong's message of "Mon, 22 Aug 2016 17:36:29 +0200")
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: thierry.reding@gmail.com, carlo@caione.org, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> Add support for the PWM controller found in Amlogic Meson SoCs.
> This controller provides a dual PWM output with 4 selectable clock source
> and a two level divider to achieve a better PWM range.
>
> Currently Meson8b and GXBB SoCs are supported.
>
> Changes since v2 at http://lkml.kernel.org/r/1471718083-11516-1-git-send-email-narmstrong@baylibre.com :
> - Switch to apply() callback only, this fixes the setup sequence
> - Implement get_state
> - Make clock parent names as DT match data
>
> Changes since v1 at http://lkml.kernel.org/r/1466173784-15625-1-git-send-email-narmstrong@baylibre.com :
> - fix meson8b dtsi
>
> Neil Armstrong (4):
>   pwm: Add support for Meson PWM Controller
>   dt-bindings: pwm: Add bindings for Meson PWM Controller

Looks like Thierry has picked up these two into his for-4.9/drivers
branch...

>   ARM64: dts: meson-gxbb: Add Meson GXBB PWM Controller nodes
>   ARM: dts: meson8b: Add Meson8b PWM Controller nodes

... so I've picked up these into the amlogic tree.

Kevin
