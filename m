From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
Subject: [PATCH v2 0/6] Updates for the atmel PWM driver
Date: Sat, 24 Aug 2019 02:10:35 +0200
Message-ID: <20190824001041.11007-1-uwe@kleine-koenig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Claudiu Beznea <claudiu.beznea@microchip.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, Alexandre Belloni <alexandre.belloni@bootlin.com>, Ludovic Desroches <ludovic.desroches@microchip.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

SGVsbG8sCgp0aGlzIGlzIHYyIG9mIG15IHNlcmllcyB0byB1cGRhdGUgdGhlIGF0bWVsIFBXTSBk
cml2ZXIuIChJbXBsaWNpdCkgdjEKd2FzIHNlbnQgb24gQXVnIDE1LCBzdGFydGluZyB3aXRoIE1l
c3NhZ2UtSWQ6CjIwMTkwODE1MjE0MTMzLjExMTM0LTEtdXdlQGtsZWluZS1rb2VuaWcub3JnLgoK
SSB1cGRhdGVkIHRoZSBwYXRjaGVzIGZyb20gdGhlIGZlZWRiYWNrIEkgZ290IGluIHYxLCBzZWUg
dGhlIGluZGl2aWR1YWwKcGF0Y2hlcyBmb3IgdGhlIGRldGFpbHMuCgpCZXN0IHJlZ2FyZHMKVXdl
CgpVd2UgS2xlaW5lLUvDtm5pZyAoNik6CiAgcHdtOiBhdG1lbDogQWRkIGEgaGludCB3aGVyZSB0
byBmaW5kIGhhcmR3YXJlIGRvY3VtZW50YXRpb24KICBwd206IGF0bWVsOiB1c2UgYSBjb25zdGFu
dCBmb3IgbWF4aW11bSBwcmVzY2FsZSB2YWx1ZQogIHB3bTogYXRtZWw6IHJlcGxhY2UgbG9vcCBp
biBwcmVzY2FsZSBjYWxjdWxhdGlvbiBieSBhZC1ob2MgY2FsY3VsYXRpb24KICBwd206IGF0bWVs
OiBkb2N1bWVudCBrbm93biB3ZWFrbmVzc2VzIG9mIGJvdGggaGFyZHdhcmUgYW5kIHNvZnR3YXJl
CiAgcHdtOiBhdG1lbDogdXNlIGF0bWVsX3B3bV93cml0ZWwgaW4gYXRtZWxfcHdtX2NoX3dyaXRl
bDsgZGl0dG8gZm9yCiAgICByZWFkbAogIHB3bTogYXRtZWw6IGltcGxlbWVudCAuZ2V0X3N0YXRl
KCkKCiBkcml2ZXJzL3B3bS9wd20tYXRtZWwuYyB8IDg2ICsrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKystLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgNzMgaW5zZXJ0aW9ucygrKSwgMTMg
ZGVsZXRpb25zKC0pCgotLSAKMi4yMC4xCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJt
LWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21h
aWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
