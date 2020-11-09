Return-Path: <SRS0=vUTe=EP=vger.kernel.org=linux-pwm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7978C2D0A3
	for <linux-pwm@archiver.kernel.org>; Mon,  9 Nov 2020 10:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86D4820679
	for <linux-pwm@archiver.kernel.org>; Mon,  9 Nov 2020 10:57:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SJ1SOPBp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbgKIK5f (ORCPT <rfc822;linux-pwm@archiver.kernel.org>);
        Mon, 9 Nov 2020 05:57:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20753 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727303AbgKIK5f (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 9 Nov 2020 05:57:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604919454;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Yj0rLVKrwx2e/48rRjGHa5Mxo3H/jb+LBHg/BpAMTAM=;
        b=SJ1SOPBpDIBKJsA341nKJeEc7RFXes46TDUUkWZ7dbXQgG4sKRocvRnOr3ncOsAa89lHMZ
        NwWqPWK9dWkVUZLBJubiCv/J3kK+mYvVwtk1ptGirNy16gMNkLaf+8mEkqBfbVKY+uHV/5
        /d5G2PpAQUqIr2c+7E0eDjumlePOwnI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-dn8KsXQyM7KXaidf_5ZBow-1; Mon, 09 Nov 2020 05:57:32 -0500
X-MC-Unique: dn8KsXQyM7KXaidf_5ZBow-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D59F9107B471;
        Mon,  9 Nov 2020 10:57:30 +0000 (UTC)
Received: from x1.localdomain (ovpn-114-3.ams2.redhat.com [10.36.114.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D03656EF4B;
        Mon,  9 Nov 2020 10:57:27 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy@infradead.org>,
        linux-pwm@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH v2 0/3] pwm: lpss: pwm: lpss: Misc. cleanups / improvements
Date:   Mon,  9 Nov 2020 11:57:23 +0100
Message-Id: <20201109105726.121512-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi All,

Now that the pwm-lpss / pwm-crc / i915 atomic PWM conversion has landed
in 5.10-rc1 here is a small follow up series with some misc. improvements.

Changes in v2:
- Extend comment to explain why the DPM_FLAG_SMART_SUSPEND is set
- Add Andy's Reviewed-by to all 3 patches

Regards,

Hans

