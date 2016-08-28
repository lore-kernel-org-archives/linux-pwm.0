From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH v3 1/4] pwm: Add support for Meson PWM Controller
Date: Sun, 28 Aug 2016 18:33:03 +0200
Message-ID: <CAFBinCA3PoR_=+f8aU-Trg8uKWWXkkBOtrQUaXbdsb8E-fdM0g@mail.gmail.com>
References: <1471880193-21879-1-git-send-email-narmstrong@baylibre.com> <1471880193-21879-2-git-send-email-narmstrong@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34017 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755674AbcH1QdZ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 28 Aug 2016 12:33:25 -0400
In-Reply-To: <1471880193-21879-2-git-send-email-narmstrong@baylibre.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: thierry.reding@gmail.com, carlo@caione.org, khilman@baylibre.com, linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, Aug 22, 2016 at 5:36 PM, Neil Armstrong <narmstrong@baylibre.com> wrote:
> Add support for the PWM controller found in the Amlogic SoCs.
> This driver supports the Meson8b and GXBB SoCs.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
I could enable the AP6330 SDIO wifi module with this on my
meson-gxbb-vega-s95-meta clone, which uses pwm_e to generate the LPO
clock for the wifi module (see [0] for the corresponding patches).
So thank you Neil, and:
Tested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>


[0] https://github.com/xdarklight/linux/tree/meson-gxbb-integration-4.8-20160828
