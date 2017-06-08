From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH v2 0/3] pwm: add pwm AO on meson gx
Date: Thu,  8 Jun 2017 14:24:13 +0200
Message-ID: <20170608122416.1993-1-jbrunet@baylibre.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wr0-f176.google.com ([209.85.128.176]:35575 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750822AbdFHMYV (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 8 Jun 2017 08:24:21 -0400
Received: by mail-wr0-f176.google.com with SMTP id q97so17856273wrb.2
        for <linux-pwm@vger.kernel.org>; Thu, 08 Jun 2017 05:24:21 -0700 (PDT)
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Kevin Hilman <khilman@baylibre.com>, Neil Armstrong <narmstrong@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, Carlo Caione <carlo@caione.org>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org

The pwms found in the AO domain of the meson gx family have different
clock sources than the ones found in the EE domain. The AO pwms only
have 2 connected clock input which are clk81 and the crytal.

This patchset adds the necessary compatible and the clock data for it.

Changes since v1: [0]
* Correct clock source order for gxbb pwm ao. Documenation shows xtal as
  source #1 while it is actually source #0
* Add patch 3 to fix pwm calculation. Issue while testing pwm with clk81
  as clock source.

[0]:  https://lkml.kernel.org/r/20170607133013.4766-1-jbrunet@baylibre.com

Jerome Brunet (3):
  dt-bindings: pwm: meson: add comptabible for gxbb ao pwms
  pwm: meson: add compatible for the gxbb ao pwms
  pwm: meson: improve pwm calculation precision.

 .../devicetree/bindings/pwm/pwm-meson.txt          |  4 +-
 drivers/pwm/pwm-meson.c                            | 47 +++++++++++++++++-----
 2 files changed, 41 insertions(+), 10 deletions(-)

-- 
2.9.4
