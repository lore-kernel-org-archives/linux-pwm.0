From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: [PATCH 0/2] ARM: adapt defconfigs to pwm driver split
Date: Thu, 10 Jan 2019 21:19:32 +0100
Message-ID: <20190110201934.4105-1-u.kleine-koenig@pengutronix.de>
References: <20190107195352.3149-5-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190107195352.3149-5-u.kleine-koenig@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Thierry Reding <thierry.reding@gmail.com>, Shawn Guo <shawnguo@kernel.org>
Cc: linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
List-Id: linux-pwm@vger.kernel.org

SGVsbG8sCgp0byBjb250aW51ZSBjb21waWxpbmcgdGhlIChub3cpIHR3byBwd20taW14IGRyaXZl
cnMgYXMgcGFydCBvZiB0aGUKaW14IGRlZmNvbmZpZ3Mgd2Ugc2hvdWxkIHVwZGF0ZSB0aGVtIHRv
IHVzZSB0aGUgbmV3IG5hbWVzLgoKSSB0aGluayB0aGUgZWFzaWVzdCBoYW5kbGluZyB3b3VsZCBi
ZSB0byBsZXQgdGhlbSBnbyB2aWEgdGhlIHB3bSB0cmVlCndpdGggU2hhd24ncyBBY2sgdG8gZ2V0
IHRoZSB1cGRhdGUgbmVhciB0byB0aGUgYWN0dWFsIHNwbGl0IGludG8KdGhlIG1haW5saW5lLgoK
QmVzdCByZWdhcmRzClV3ZQoKVXdlIEtsZWluZS1Lw7ZuaWcgKDIpOgogIEFSTTogaW14X3Y2X3Y3
X2RlZmNvbmZpZzogY29udGludWUgY29tcGlsaW5nIHRoZSBwd20gZHJpdmVyCiAgQVJNOiBpbXhf
djRfdjVfZGVmY29uZmlnOiBlbmFibGUgUFdNIGRyaXZlcgoKIGFyY2gvYXJtL2NvbmZpZ3MvaW14
X3Y0X3Y1X2RlZmNvbmZpZyB8IDMgKysrCiBhcmNoL2FybS9jb25maWdzL2lteF92Nl92N19kZWZj
b25maWcgfCAyICstCiAyIGZpbGVzIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlv
bigtKQoKLS0gCjIuMjAuMQoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxA
bGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
