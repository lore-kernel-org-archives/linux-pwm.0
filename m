Return-Path: <SRS0=cZm8=DN=vger.kernel.org=linux-pwm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84AAAC46466
	for <linux-pwm@archiver.kernel.org>; Tue,  6 Oct 2020 08:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 423AC208FE
	for <linux-pwm@archiver.kernel.org>; Tue,  6 Oct 2020 08:19:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbgJFITa (ORCPT <rfc822;linux-pwm@archiver.kernel.org>);
        Tue, 6 Oct 2020 04:19:30 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:34866 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726779AbgJFITV (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 6 Oct 2020 04:19:21 -0400
X-IronPort-AV: E=Sophos;i="5.77,342,1596466800"; 
   d="scan'208";a="59034259"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 06 Oct 2020 17:19:14 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 429F2400265E;
        Tue,  6 Oct 2020 17:19:11 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar <prabhakar.csengg@gmail.com>
Subject: [PATCH v2 0/2] dt-bindings: Document tpu, pwm support for R8A7742
Date:   Tue,  6 Oct 2020 09:19:08 +0100
Message-Id: <20201006081910.1238-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi All,

This patches are part of series [1], where patch 1/2 was missed to be applied
before YAML conversation and patch 2/2 was never applied.

I have restored the Acks for patch 1/2 and patch 2/2 is unchanged.

[1] https://patchwork.kernel.org/project/linux-renesas-soc/list/?series=329853

Cheers,
Prabhakar

Lad Prabhakar (2):
  dt-bindings: pwm: renesas,tpu-pwm: Document r8a7742 support
  dt-bindings: pwm: renesas,pwm-rcar: Add r8a7742 support

 Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.yaml | 1 +
 Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml  | 1 +
 2 files changed, 2 insertions(+)

-- 
2.17.1

